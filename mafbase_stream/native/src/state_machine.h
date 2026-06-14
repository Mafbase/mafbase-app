#ifndef MAFBASE_STREAM_STATE_MACHINE_H
#define MAFBASE_STREAM_STATE_MACHINE_H

#include <functional>

#include "mafbase_stream/session.h"

namespace mafbase_stream {

// Минимальная state machine стрим-сессии: idle → connecting → streaming →
// reconnecting → stopped. Логика переходов специально простая — она же служит
// контрактом для тестов и future-проверок (legal transition guard).
class StateMachine {
public:
    using Listener = std::function<void(ms_state from, ms_state to)>;

    StateMachine();

    ms_state state() const noexcept;

    // Слушатель вызывается ПОСЛЕ применения перехода. Один слушатель на инстанс.
    // Listener должен быть лёгким — обычно просто публикация события наружу.
    void set_listener(Listener listener);

    // Возвращает true, если переход разрешён, и применяет его. Возвращает false
    // (и не меняет состояние), если переход запрещён.
    bool transition_to(ms_state next);

private:
    ms_state state_;
    Listener listener_;
};

bool is_legal_transition(ms_state from, ms_state to);

}  // namespace mafbase_stream

#endif
