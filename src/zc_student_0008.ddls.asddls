@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View Entity - Student'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZC_STUDENT_0008
  provider contract transactional_query
  as projection on ZI_STUDENT_0008 as Student
{
      @EndUserText.label: 'Student ID'
  key Id,
      @EndUserText.label: 'First Name'
      Firstname,
      @EndUserText.label: 'Last Name'
      Lastname,
      @EndUserText.label: 'Age'
      Age,
      @EndUserText.label: 'Course'
      Course,
      @EndUserText.label: 'Course Duration'
      Courseduration,
      @EndUserText.label: 'Status'
      Status,
      @EndUserText.label: 'Gender'
      Gender,
      @EndUserText.label: 'Date of Birth'
      Dob,
      Lastchangedat,
      Locallastchangedat
}
