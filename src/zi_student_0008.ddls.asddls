@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity View for Student'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZI_STUDENT_0008
  as select from zgy_rap_0008
  association to zi_gender_0008    as _gender on $projection.Gender = _gender.Value
  composition [0..*] of ZI_AR_0008 as _academicres
{
  key id                  as Id,
      firstname           as Firstname,
      lastname            as Lastname,
      age                 as Age,
      course              as Course,
      courseduration      as Courseduration,
      status              as Status,
      gender              as Gender,
      dob                 as Dob,
      salary              as Salary,
      role                as Role,
      lastchangedat       as Lastchangedat,
      locallastchangedat  as Locallastchangedat,
      _gender,
      _gender.Description as Genderdesc,
      _academicres
}
