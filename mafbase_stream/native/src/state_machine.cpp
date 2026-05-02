#include "state_machine.h"

namespace mafbase_stream {

StateMachine::StateMachine() : state_(MS_STATE_IDLE) {}

ms_state StateMachine::state() const noexcept { return state_; }

bool StateMachine::transition_to(ms_state next) {
    if (!is_legal_transition(state_, next)) {
        return false;
    }
    state_ = next;
    return true;
}

bool is_legal_transition(ms_state from, ms_state to) {
    if (from == to) {
        return true;
    }
    switch (from) {
        case MS_STATE_IDLE:
            return to == MS_STATE_CONNECTING || to == MS_STATE_STOPPED;
        case MS_STATE_CONNECTING:
            return to == MS_STATE_STREAMING || to == MS_STATE_STOPPED || to == MS_STATE_RECONNECTING;
        case MS_STATE_STREAMING:
            return to == MS_STATE_RECONNECTING || to == MS_STATE_STOPPED;
        case MS_STATE_RECONNECTING:
            return to == MS_STATE_STREAMING || to == MS_STATE_STOPPED;
        case MS_STATE_STOPPED:
            return false;
    }
    return false;
}

}  // namespace mafbase_stream
