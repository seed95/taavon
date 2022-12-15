#ifndef TVN_CSV_H
#define TVN_CSV_H

#include <QObject>

#include "tvn_sharing.h"


#define HEADER_NAME_FILE_CODE                           "کد پرونده"
#define HEADER_NAME_KEEPING_PLACE                       "محل نگهداری"
#define HEADER_NAME_STATUS                              "وضعیت"
#define HEADER_NAME_LEDGER_BINDER                       "کد فایل"
#define HEADER_NAME_NUMBER_OF_COVER                     "تعداد جلد"
#define HEADER_NAME_FILE_NAME                           "اسم شرکت"
#define HEADER_NAME_REGISTRATION_NUMBER                 "شماره ثبت"
#define HEADER_NAME_DATE_OF_REGISTRATION                "تاریخ ثبت"
#define HEADER_NAME_NATIONAL_ID                         "شناسه ملی"
#define HEADER_NAME_DATE_OF_LAST_MEETING                "تاریخ آخرین مجمع"
#define HEADER_NAME_NUMBER_OF_PRIMARY_MEMBERS           "اعضای اولیه"
#define HEADER_NAME_NUMBER_OF_CURRENT_MEMBERS           "اعضای فعلی"
#define HEADER_NAME_VALUE_PER_SHARE                     "ارزش اسمی"
#define HEADER_NAME_STARTING_CAPITAL                    "سرمایه اولیه"
#define HEADER_NAME_CURRENT_CAPITAL                     "سرمایه فعلی"
#define HEADER_NAME_PHONE_NUMBER                        "تلفن"
#define HEADER_NAME_MOBILE_NUMBER                       "موبایل"
#define HEADER_NAME_ADDRESS                             "آدرس"
#define HEADER_NAME_CEO_NAME                            "مدیر عامل"
#define HEADER_NAME_CHAIRMAN_NAME                       "رئیس"
#define HEADER_NAME_VICE_NAME                           "نائب رئیس"
#define HEADER_NAME_SECRETARY_NAME                      "منشی"
#define HEADER_NAME_IMAGE_EXTRAORDINARY_MEETING         "عکس آخرین مجمع فوق العاده"
#define HEADER_NAME_IMAGE_GENERAL_MEETING               "عکس آخرین مجمع سالانه"
#define HEADER_NAME_IMAGE_LICENCE                       "عکس مجوز"
#define HEADER_NAME_IMAGE_REGISTRATION_AD               "عکس آگهی ثبت"

#define HEADER_INDEX_FILE_CODE                      0
#define HEADER_INDEX_KEEPING_PLACE                  1
#define HEADER_INDEX_STATUS                         2
#define HEADER_INDEX_LEDGER_BINDER                  3
#define HEADER_INDEX_NUMBER_OF_COVER                4
#define HEADER_INDEX_FILE_NAME                      5
#define HEADER_INDEX_REGISTRATION_NUMBER            6
#define HEADER_INDEX_DATE_OF_REGISTRATION           7
#define HEADER_INDEX_NATIONAL_ID                    8
#define HEADER_INDEX_DATE_OF_LAST_MEETING           9
#define HEADER_INDEX_NUMBER_OF_PRIMARY_MEMBERS      10
#define HEADER_INDEX_NUMBER_OF_CURRENT_MEMBERS      11
#define HEADER_INDEX_VALUE_PER_SHARE                12
#define HEADER_INDEX_STARTING_CAPITAL               13
#define HEADER_INDEX_CURRENT_CAPITAL                14
#define HEADER_INDEX_PHONE_NUMBER                   15
#define HEADER_INDEX_MOBILE_NUMBER                  16
#define HEADER_INDEX_ADDRESS                        17
#define HEADER_INDEX_CEO_NAME                       18
#define HEADER_INDEX_CHAIRMAN_NAME                  19
#define HEADER_INDEX_VICE_NAME                      20
#define HEADER_INDEX_SECRETARY_NAME                 21
#define HEADER_INDEX_IMAGE_EXTRAORDINARY_MEETING    22
#define HEADER_INDEX_IMAGE_GENERAL_MEETING          23
#define HEADER_INDEX_IMAGE_LICENCE                  24
#define HEADER_INDEX_IMAGE_REGISTRATION_AD          25

#define HEADER_INDEX_TOTAL_NUMBER 26


class TvnCsv : public QObject
{
    Q_OBJECT
public:
    explicit TvnCsv(QObject *root, TvnSharing *sharing, QObject *parent = nullptr);

    static bool SaveImageChanges(QObject *ui, bool upload);

public:
    void LoadCsv();

private slots:
    // Edit slots
    void SaveChanges();

    // Sharing slots
    void finishProcess();
    void errorProcess();

private:
    QObject *root;
    QObject *list;
    QObject *edit;

    TvnSharing *sharing;
};

#endif // TVN_CSV_H
