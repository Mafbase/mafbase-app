#ifndef MAFBASE_STREAM_STATE_MACHINE_H
#define MAFBASE_STREAM_STATE_MACHINE_H

#include "mafbase_stream/session.h"

namespace mafbase_stream {

// Минимальная state machine стрим-сессии: idle → connecting → streaming →
// reconnecting → stopped. Логика переходов специально простая — она же служит
// контрактом для тестов и future-проверок (legal transition guard).
class StateMachine {
public:
    StateMachine();

    ms_state state() const noexcept;

    // Возвращает true, если переход разрешён, и применяет его. Возвращает false
    // (и не меняет состояние), если переход запрещён.
    bool transition_to(ms_state next);

private:
    ms_state state_;
};

bool is_legal_transition(ms_state from, ms_state to);

}  // namespace mafbase_stream

#endif
