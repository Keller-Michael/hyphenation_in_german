CLASS zcl_hyphenation DEFINITION
                      PUBLIC
                      FINAL
                      CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF separation_result,
             left_word  TYPE string,
             right_word TYPE string,
           END OF separation_result.

    TYPES: separation_results TYPE STANDARD TABLE OF separation_result WITH DEFAULT KEY.

    METHODS constructor.

    METHODS separate_german_word
      IMPORTING
        word_to_separate TYPE string
      RETURNING
        VALUE(results)   TYPE separation_results.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_hyphenation IMPLEMENTATION.

  METHOD constructor.
  ENDMETHOD.

  METHOD separate_german_word.
    DATA result TYPE separation_result.

    IF word_to_separate IS INITIAL.
      RETURN.
    ENDIF.

    DATA(word_length) = strlen( word_to_separate ).
    DATA(current_position) = word_length - 1.

    DO.
      IF current_position <= 0.
        EXIT.
      ENDIF.

      DATA(current_character) = word_to_separate+current_position(1).
      current_position = current_position - 1.
      IF current_character CA 'aeiouyäöü'.
        DO.
          IF current_position <= 0.
            EXIT.
          ENDIF.

          current_character = word_to_separate+current_position(1).

          IF current_character CN 'aeiouy'.
            result-left_word = word_to_separate+0(current_position).
            DATA(length_right_word) = word_length - current_position.
            result-right_word = word_to_separate+current_position(length_right_word).
            APPEND result TO results.
            EXIT.
          ENDIF.

          current_position = current_position - 1.
        ENDDO.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
