@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity View  Academic Result'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity ZI_AR_0008
  as select from zgy_ar_0008
  association to parent ZI_STUDENT_0008 as _student  on $projection.Id = _student.Id
  association to ZI_COURSE_0008         as _course   on $projection.Course = _course.Value
  association to ZI_SEM_0008            as _semester on $projection.Semester = _semester.Value
  association to ZI_SEMRES_0008         as _semres   on $projection.Semresult = _semres.Value
{
  key id                    as Id,
  key course                as Course,
  key semester              as Semester,
      _course.Description   as course_desc,
      _semester.Description as semester_desc,
      semresult             as Semresult,
      _semres.Description   as semres_desc,
      _student
}
