*&---------------------------------------------------------------------*
*& Report zhyphenation_test_area
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zhyphenation_test_area.

PARAMETERS input TYPE string.

DATA(hyphenation) = NEW zcl_hyphenation( ).

SPLIT input AT space INTO TABLE DATA(input_words).

DATA results TYPE zcl_hyphenation=>separation_results.
DATA result TYPE zcl_hyphenation=>separation_result.

LOOP AT input_words INTO DATA(word).
  word = to_lower( word ).
  results = hyphenation->separate_german_word( word ).
  IF results IS INITIAL.
    WRITE: / 'No results for ', word COLOR COL_NEGATIVE.
  ELSE.
    LOOP AT results INTO result.
      WRITE: / 'Results for ', word, result-left_word COLOR COL_POSITIVE, result-right_word COLOR COL_POSITIVE.
    ENDLOOP.
  ENDIF.
ENDLOOP.
