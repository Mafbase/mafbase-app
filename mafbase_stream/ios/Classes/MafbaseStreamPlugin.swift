import Flutter
import UIKit

public class MafbaseStreamPlugin: NSObject, FlutterPlugin {
  private var pendingResult: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mafbase_stream", binaryMessenger: registrar.messenger())
    let instance = MafbaseStreamPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "openStreamScreen":
      openStreamScreen(call: call, result: result)
    case "openOverlayPreview":
      openOverlayPreview(call: call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func openStreamScreen(call: FlutterMethodCall, result: @escaping FlutterResult) {
    if pendingResult != nil {
      result(FlutterError(code: "ALREADY_OPEN", message: "Stream screen is already open", details: nil))
      return
    }
    guard let presenter = topViewController() else {
      result(FlutterError(code: "NO_PRESENTER", message: "No view controller to present from", details: nil))
      return
    }
    pendingResult = result

    let args = call.arguments as? [String: Any]
    let rtmpUrl = (args?["rtmpUrl"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
    let streamKey = (args?["streamKey"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
    let overlayViewType = (args?["overlayViewType"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
    let tournamentId = (args?["tournamentId"] as? NSNumber)?.intValue
    let table = (args?["table"] as? NSNumber)?.intValue

    let controller = StreamViewController()
    controller.rtmpUrl = (rtmpUrl?.isEmpty == false) ? rtmpUrl! : "rtmp://10.0.2.2/live"
    controller.streamKey = (streamKey?.isEmpty == false) ? streamKey! : "test"
    controller.overlayViewType = (overlayViewType?.isEmpty == false) ? overlayViewType : nil
    controller.overlayParams = OverlayParams(tournamentId: tournamentId, table: table)
    controller.modalPresentationStyle = .fullScreen
    controller.onClose = { [weak self] reason in
      guard let self = self, let pending = self.pendingResult else { return }
      self.pendingResult = nil
      switch reason {
      case .user:
        pending(nil)
      case .permissionsDenied:
        pending(
          FlutterError(
            code: "PERMISSIONS_DENIED",
            message: "Camera or microphone permissions denied",
            details: nil
          )
        )
      }
    }
    presenter.present(controller, animated: true, completion: nil)
  }

  private func openOverlayPreview(call: FlutterMethodCall, result: @escaping FlutterResult) {
    if pendingResult != nil {
      result(
        FlutterError(
          code: "ALREADY_OPEN",
          message: "Another mafbase_stream screen is already open",
          details: nil
        )
      )
      return
    }
    guard let args = call.arguments as? [String: Any],
          let viewType = (args["overlayViewType"] as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines),
          !viewType.isEmpty
    else {
      result(
        FlutterError(code: "INVALID_ARGUMENT", message: "overlayViewType is required", details: nil)
      )
      return
    }
    guard OverlayCatalog.has(viewType: viewType) else {
      result(
        FlutterError(
          code: "OVERLAY_NOT_FOUND",
          message: "No overlay registered in plugin catalog for viewType '\(viewType)'",
          details: nil
        )
      )
      return
    }
    guard let presenter = topViewController() else {
      result(FlutterError(code: "NO_PRESENTER", message: "No view controller to present from", details: nil))
      return
    }
    pendingResult = result

    let tournamentId = (args["tournamentId"] as? NSNumber)?.intValue
    let table = (args["table"] as? NSNumber)?.intValue
    let params = OverlayParams(tournamentId: tournamentId, table: table)

    let controller = OverlayPreviewViewController(overlayViewType: viewType, params: params)
    controller.modalPresentationStyle = .fullScreen
    controller.onClose = { [weak self] in
      guard let self = self, let pending = self.pendingResult else { return }
      self.pendingResult = nil
      pending(nil)
    }
    presenter.present(controller, animated: true, completion: nil)
  }

  private func topViewController() -> UIViewController? {
    let root = activeKeyWindow()?.rootViewController
    var current = root
    while let presented = current?.presentedViewController {
      current = presented
    }
    return current
  }

  private func activeKeyWindow() -> UIWindow? {
    if #available(iOS 13.0, *) {
      let scenes = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .filter { $0.activationState == .foregroundActive }
      if let window = scenes.flatMap({ $0.windows }).first(where: { $0.isKeyWindow }) {
        return window
      }
      return scenes.flatMap { $0.windows }.first
    }
    return UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
  }
}
