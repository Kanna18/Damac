//
//  DamacConstants.h
//  DamacC
//
//  Created by Gaian on 02/05/18.
//  Copyright © 2018 DamacCOrganizationName. All rights reserved.
//

#ifndef DamacConstants_h
#define DamacConstants_h

#define defaultSet(value,key)   [[NSUserDefaults standardUserDefaults]setValue:value forKey:key]
#define defaultGet(key)         [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define defaultSetBool(boo,key) [[NSUserDefaults standardUserDefaults]setBool:boo forKey:key]
#define defaultGetBool(key)     [[NSUserDefaults standardUserDefaults]boolForKey:key]
#define defaultRemove(key)      [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]
#define kUserProfile             [DamacSharedClass sharedInstance].userProileModel

#define handleNull(val)         val?val:@""
#define isEmpty(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0?NO:YES

#define goldColor rgb(191, 154, 88)

#define  kMPin @"MPIN"
#define kfingerPrintAccessGranted @"FingerPrintAccess"
#define kconfirmMpin @"CONFIRM_MPIN"
#define kenterMpin @"EnterMpin"
#define MPIN_ENTERED_NOTIFICATION @"MPINEntered"//Notification for PKey View Controller

#define kFingerPrintAvailabe @"FingerPrintAvailable"
#define kFaceIDAvailabe @"FaceIDAvailabe"

#define rgb(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kMyUnits @"MY UNITS"
#define kMyServiceRequests @"SERVICE REQUEST"
#define kMyPaymentScedules @"PAYMENT SCHEDULE"
#define kEServices @"CREATE REQUESTS"
#define kMyReceipts @"RECEIPTS"
#define kSOA @"APPOINTMENT"
#define kPay @"PAY NOW"
#define kComplaints @"COMPLAINTS"
#define kSurveys @"SURVEY"
#define kprofilePage @"My Profile"

#pragma mark Sidemenu Constants

#define kLogout @"Logout"


#pragma mark flying Options
#define fyProfile @"MY PROFILE"
#define fyCreateReq @"RAISE SERVICE REQUESTS"
#define fyScheduleAppointments @"SCHEDULE APPOINTMENTS"
#define fyLiveChat @"EMAIL"
#define fyCustomerSer @"CALL CUSTOMER SERVICE"

#pragma mark Webservices
#define maiUrl @"https://ptctest.damacgroup.com/DCOFFEE/force/userid/"
#define unitsServiceUrl @"https://ptctest.damacgroup.com/DCOFFEE/registration/party/"

#define myServicesUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/getCaseDetails/"
#define getAppointments @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SendAppointmentsToMObileApp/"

#define jointBuyersUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/GetBuyersInfoToMobileApp/" /*To get Joint Buyers info need to pass SFID*/ //(SFID is not getting in Units API so calling Bookings API to get SFIDS )
#define bookingsAPI @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/GetMyUnitBookings/" /*Requires Account ID from UserData Model*/

#define createAppointmentRequest @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveScheduleAppointment/" /*Create a service Reequest*/

#define getReceiptsRequest @"https://ptctest.damacgroup.com/DCOFFEE/receipt/party/"

#define prrofOfPayment @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveProofOfPayment/"

#define kgetCountriesList @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SendCountriesListToMobileApp"

#define ChangeofDetailsServicesUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveChangeOfDetailsCase/"

#define ComplaintsServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveComplaintFromMobileApp/"
#define ProofOFPaymentServiceURl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveProofOfPayment/"
#define JointBuyerServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveJointBuyerDetails/"
#define PassportUpdateServiceUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SaveUpdatePassportDetails/"
#define downloadFormUrl @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SendCOCDUrlToMObileApp/"


#define getDetailsBySR @"https://partial-servicecloudtrial-155c0807bf-1580afc5db1.cs80.force.com/MobileApp/services/apexrest/SendCaseDetailToMObileApp/"



#pragma mark Arrays
//#define kpersonalDetails @"Personal Details"
//#define kpropertyPayments @"Proof Payments" //@"Property Payments"
//#define kAppointments @"Appointments"
#define kCod @"CHANGE OF CONTACT\nDETAILS"
#define kPassportUpdate @"PASSPORT UPDATE"
#define kJointBuyerInfo @"JOINT BUYER INFO"
#define kProofOfPayment @"PROOF OF PAYMENT"
#define kAppointments @"APPOINTMENTS"
#define kComplaints @"COMPLAINTS"
#define eservicesArray  @[kCod,kPassportUpdate,kJointBuyerInfo,kProofOfPayment,kAppointments,kComplaints,]//@[kpersonalDetails,kpropertyPayments,kAppointments]


#define kchangeofPrimarycontactdetails @"Change of Primary\nContact Details"
#define kchangeofJointBuyerDetails @"Change of Joint Buyer\nDetails"
#define kcahngeofNameNationality @"Change of Name/\nNationality"
#define kpassportUpdate @"Passport Update"
#define personalDetailsArray  @[kchangeofPrimarycontactdetails,kcahngeofNameNationality]// @[kchangeofPrimarycontactdetails,kchangeofJointBuyerDetails,kcahngeofNameNationality,kpassportUpdate]


#define kFurniture @"Furniture"
#define kAdditionalOarking @"Additional Parking"
#define kNocForVISA @"NOC For VISA"
#define appointmentsArray @[kFurniture,kAdditionalOarking,kNocForVISA]

#define radiusCommon 10
#define borderWidthCommon 1.0f
#define  borderColorCommon rgb(255, 192, 69).CGColor


#define kloadingFromMenu @"LoadingFromMenu"
#define kloadingFromCreateServices @"LoadingFromCreateServices"


#pragma mark TopGridArrayConstants
#define overallPortofolio @"Overall Portfolio Value"
#define currentPortofolio @"Current Portfolio Value"
#define paymentsDue @"Payments Due"
#define openServiceRequests @"Open Service Requests"


typedef NS_ENUM(int) {
    Mobile = 101010,
    Email,
    Address1,
    Address2,
    Address3,
    Address4,
    City,
    State,
    PostalCode,
    Address1Arabic,
    CityArabic,
    CountryArabic,
    StateInArabic
}TextFieldTagsCocd;

typedef NS_ENUM(int) {
    Address1J = 202020,
    Address2J,
    Address3J,
    Address4J,
    CityJ,
    StateJ,
    PostalCodeJ,
    EmailJ,
    MobileJ,
}TextFieldTagsJointBuyer;

#endif /* DamacConstants_h */
