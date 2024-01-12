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
      course_desc,
      @EndUserText.label: 'Course Duration'
      Courseduration,
      @EndUserText.label: 'Status'
      Status,
      @EndUserText.label: 'Gender'
      Gender,
      Genderdesc,
      @EndUserText.label: 'Date of Birth'
      Dob,
      @EndUserText.label: 'Salary'
      Salary,
      @EndUserText.label: 'Role'
      Role,
      Lastchangedat,
      Locallastchangedat,
      _academicres : redirected to composition child ZC_AR_0008,
      @ObjectModel.virtualElementCalculatedBy: 'ZCL_CALCULATE_0008'
      @EndUserText.label: 'Total Pay'
      virtual BonusAmount : abap.int4
}
