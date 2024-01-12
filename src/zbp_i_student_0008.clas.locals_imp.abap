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
    METHODS updatecourseduration FOR DETERMINE ON SAVE
      IMPORTING keys FOR student~updatecourseduration.
    METHODS changesalary FOR DETERMINE ON MODIFY
      IMPORTING keys FOR student~changesalary.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE student.

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

  METHOD updateCourseDuration.

    READ ENTITIES OF zi_student_0008 IN LOCAL MODE
    ENTITY Student
    FIELDS ( Course ) WITH CORRESPONDING #( keys )
    RESULT DATA(studentsCourse).

    LOOP AT studentscourse  INTO DATA(studentCourse).
      CASE studentcourse-Course.
        WHEN 'Calculus'.
          MODIFY ENTITIES OF zi_student_0008 IN LOCAL MODE
          ENTITY Student
          UPDATE
          FIELDS ( Courseduration ) WITH VALUE #( ( %tky = studentcourse-%tky Courseduration = 5 ) ).
        WHEN 'Electronic Circuits'.
          MODIFY ENTITIES OF zi_student_0008 IN LOCAL MODE
          ENTITY Student
          UPDATE
          FIELDS ( Courseduration ) WITH VALUE #( ( %tky = studentcourse-%tky Courseduration = 7 ) ).
        WHEN 'Microcontrollers'.
          MODIFY ENTITIES OF zi_student_0008 IN LOCAL MODE
          ENTITY Student
          UPDATE
          FIELDS ( Courseduration ) WITH VALUE #( ( %tky = studentcourse-%tky Courseduration = 3 ) ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD changeSalary.

    READ ENTITIES OF zi_student_0008 IN LOCAL MODE
    ENTITY Student
    FIELDS ( Course ) WITH CORRESPONDING #( keys )
    RESULT DATA(lt_roles).

    LOOP AT lt_roles INTO DATA(ls_role).
      CASE ls_role-Role.
        WHEN 'Proffessor'.
          MODIFY ENTITIES OF zi_student_0008 IN LOCAL MODE
          ENTITY Student
          UPDATE
          FIELDS ( Salary ) WITH VALUE #( ( %tky = ls_role-%tky Salary = 1000 ) ).
        WHEN 'Teacher'.
          MODIFY ENTITIES OF zi_student_0008 IN LOCAL MODE
          ENTITY Student
          UPDATE
          FIELDS ( Salary ) WITH VALUE #( ( %tky = ls_role-%tky Salary = 900 ) ).
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD precheck_update.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).
      CHECK <lfs_entity>-Course EQ '01' OR <lfs_entity>-Courseduration EQ '01'.
      READ ENTITIES OF zi_student_0008 IN LOCAL MODE
      ENTITY Student
      FIELDS ( Course Courseduration ) WITH VALUE #( ( %key = <lfs_entity>-%key ) )
      RESULT DATA(lt_course).

      IF sy-subrc IS INITIAL.
        READ TABLE lt_course ASSIGNING FIELD-SYMBOL(<lfs_course>) INDEX 1.
        IF sy-subrc IS INITIAL.
          <lfs_course>-Course = COND #( WHEN <lfs_entity>-Course EQ '01' THEN <lfs_entity>-Course ELSE <lfs_course>-Course ).
          <lfs_course>-Courseduration = COND #( WHEN <lfs_entity>-Courseduration EQ '01' THEN <lfs_entity>-Courseduration ELSE <lfs_course>-Courseduration ).
          IF <lfs_course>-Courseduration LT 5.
            IF <lfs_course>-Course = 'Calculus'.
              APPEND VALUE #( %tky = <lfs_entity>-%tky ) TO failed-student.
              APPEND VALUE #( %tky = <lfs_entity>-%tky
              %msg = new_message_with_text(
                       severity = if_abap_behv_message=>severity-error
                       text     = 'Invalid Course duration!'
                     ) ) TO reported-student.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
