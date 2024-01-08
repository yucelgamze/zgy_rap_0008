@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View Entity Academic Result'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_AR_0008 
as projection on ZI_AR_0008 as Academic
{
      @EndUserText.label: 'Student ID'
  key Id,
      @EndUserText.label: 'Course'
  key Course,
      @EndUserText.label: 'Semester'
  key Semester,
      @EndUserText.label: 'Course Description'
      course_desc,
      @EndUserText.label: 'Semester Description'
      semester_desc,
      @EndUserText.label: 'Semester Result'
      Semresult,
      @EndUserText.label: 'Semester Result Description'
      semres_desc,
      /* Associations */
      _student : redirected to parent ZC_STUDENT_0008
}
