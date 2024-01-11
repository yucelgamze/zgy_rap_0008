CLASS zcl_calculate_0008 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_calculate_0008 IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_professorsData TYPE STANDARD TABLE OF zc_student_0008 WITH DEFAULT KEY.
    lt_professorsdata = CORRESPONDING #( it_original_data ).

    LOOP AT lt_professorsdata ASSIGNING FIELD-SYMBOL(<lfs_professors>).
      IF ( <lfs_professors>-Role EQ 'Proffessor' ).
        <lfs_professors>-BonusAmount = <lfs_professors>-Salary + 1000.
      ELSE.
        <lfs_professors>-BonusAmount = <lfs_professors>-Salary + 900.
      ENDIF.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_professorsdata ).

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.

ENDCLASS.
