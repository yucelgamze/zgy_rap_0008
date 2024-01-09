CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.
    METHODS setadmitted FOR MODIFY
      IMPORTING keys FOR ACTION student~setadmitted RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR student RESULT result.
    METHODS validateage FOR VALIDATE ON SAVE
      IMPORTING keys FOR student~validateage.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_student_0008 IN LOCAL MODE
    ENTITY Student
    FIELDS ( Status ) WITH CORRESPONDING #( keys )
    RESULT DATA(studentadmitted)
    FAILED failed.

    result = VALUE #( FOR student IN studentadmitted
     LET statusvalue = COND #( WHEN student-Status = abap_true THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
     IN ( %tky = student-%tky %action-setAdmitted = statusvalue ) ).
  ENDMETHOD.

  METHOD setAdmitted.

    MODIFY ENTITIES OF zi_student_0008 IN LOCAL MODE
    ENTITY Student
    UPDATE
    FIELDS ( Status )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky Status = abap_true ) )
    FAILED failed
    REPORTED reported.

    "güncellenmiş kaydı okuma

    READ ENTITIES OF zi_student_0008 IN LOCAL MODE
    ENTITY Student
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(data).

    result = VALUE #( FOR studentdata IN data ( %tky = studentdata-%tky %param = studentdata ) ).

  ENDMETHOD.


  METHOD validateAge.

    READ ENTITIES OF zi_student_0008 IN LOCAL MODE
    ENTITY Student
    FIELDS ( Age ) WITH CORRESPONDING #( keys )
    RESULT DATA(studentsAge).

    LOOP AT studentsAge INTO DATA(studentAge).
      IF studentage-Age LT 21.
        APPEND VALUE #( %tky = studentage-%tky ) TO failed-student.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = |Age cannot be less than 21 |
                               ) ) TO reported-student.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
