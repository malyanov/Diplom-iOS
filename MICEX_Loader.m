//
//  MICEX_Loader.m
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MICEX_Loader.h"

@implementation MICEX_Loader
static const int EmitentIds[]={6,16049,19676,74744,74745,35363,17137,21167,20737,66644,74584,81040,39,40,74726,467,22843,20703,17564,35350,35351,13855,80863,19915,16452,20702,29,20066,22797,17375,17376,15914,35242,35243,20706,21078,22602,15545,17942,20719,19043,19632,17257,16352,15965,17068,17067,16456,16457,17474,20958,20959,16842,795,35220,509,2,20708,35334,18564,19724,16825,16140,16141,74461,17919,17920,22454,80915,556,603,35332,15547,21003,81036,20516,9,15544,17359,22525,20891,16284,16285,20709,15717,16329,80313,20030,20498,18310,18391,16694,16695,75094,20890,20710,511,510,15518,20912,20913,66692,19916,522,35285,20204,19736,8,22094,21004,542,31,19737,15345,12983,12984,20057,20947,22710,16782,80390,16917,20309,20412,20402,20107,20235,20286,20346,20681,80850,15523,80621,74562,74563,17086,30,51,22652,21018,80745,16359,16804,16933,21005,74549,21116,20100,20101,17046,19629,80728,585,16615,16616,17370,66694,18500,19738,18684,17204,18584,16440,19739,15843,15844,21006,20711,22555,22891,22736,16369,18654,17850,35247,20895,16909,16908,20894,18236,17123,80818,22806,20881,74779,74446,20637,19599,16610,17713,35248,66693,16866,17273,7,15,80867,80868,80869,80870,80871,80872,80873,80874,80875,80876,80877,80878,80879,80880,80881,80882,16783,16784,80941,20266,74718,66893,20712,35238,16455,22401,20892,16080,20899,21007,22788,74540,3,23,22711,17921,17922,16136,21166,20713,20898,19651,17698,19715,15723,15722,20087,20088,21105,4,13,20715,16921,74344,18382,19814,19968,18176,17597,18189,17282,17618,17502,20716,74746,18441,74628,74629,80593,74728,19012,16265,16266,825,826,18371,21002,16797,16798,19897,74561,1012,81003,81004,20718,16805,75124,80307,16517,16518,81054,81055,19623,16173,20509,19717,22603,18425,20971,20972,19095,19096,15724,21000,21001,20999,19960,16712,16713,20125,16453,16454,20321,66848,15522,20717,20523,15903,80316,15736};
static const short EmitentMarket=1;
static const NSString* EmitentNames[]={@"+МосЭнерго",@"7Континент",@"iАрмада",@"iДонскЗР",@"iДонскЗР п",@"iЗаводДИОД",@"iИСКЧ ао",@"iНЕКК ао",@"iО2ТВ-ао",@"iРНТ",@"iФармсинтз",@"iЮтинет.Ру",@"АВТОВАЗ ао",@"АВТОВАЗ ап",@"АГАВА-Рес",@"Авангрд-ао",@"АвиастК ао",@"Азот ао",@"Акрон",@"АпДалСв ао",@"АпДалСв ап",@"Аптеки36и6",@"Армада002D",@"Арсагера",@"АстрЭнСб",@"АшинскийМЗ",@"Аэрофлот",@"БСП ао",@"БСП ап",@"Балтика ао",@"Балтика ап",@"БанкМосквы",@"БашИнСв ао",@"БашИнСв ап",@"БашЭнрг ао",@"Белон ао",@"БизнАкт ао",@"ВБД ПП ао",@"ВЕРОФАРМ",@"ВМЗ ао",@"ВТБ ао",@"ВТГК",@"ВХЗ-ао",@"ВЭК 01 ао",@"Верхнесалд",@"Возрожд-ао",@"Возрожд-п",@"ВолгЭнСб",@"ВолгЭнСб-п",@"ВологСб",@"ВостРАО ао",@"ВостРАО ап",@"ГАЗПРОМ ао",@"ГМКНорНик",@"ГПНХСал ао",@"ГУМ",@"Газпрнефть",@"ДВМП ао",@"ДИК ао",@"ДИКСИ Гр.",@"ДЭК ао",@"ДагСб ао",@"ДальВостБ",@"ДальВостБп",@"Данильч ап",@"Дорогбж ао",@"Дорогбж ап",@"ЕрмакИнв",@"ЗИРЕРА ао",@"ЗМЗ-ао",@"ЗМЗ-ап",@"ЗолЯкутии",@"ИРКУТ-3",@"Икар ао",@"ИнтерРАО2D",@"ИнтерРАОао",@"ИркЭнерго",@"КАМАЗ",@"КЗМС ао",@"КМЗ",@"КНОС-ао",@"КСБ ао",@"КСБ ап",@"КазанскВЗ",@"Калина-ао",@"КалужскСК",@"КамскДК ао",@"КамчатЭ ао",@"КамчатЭ ап",@"Квадра",@"Квадра-п",@"КировЭС ао",@"КировЭС ап",@"Кокс ао",@"КолЭС ао",@"КоршГОК ао",@"КрасОкт-1п",@"КрасОкт-ао",@"КраснГЭС",@"Красэсб ао",@"Красэсб ап",@"КубанСт ап",@"КубаньЭнСб",@"Кубанэнр",@"КузбТК ао",@"Кузбасэнрг",@"ЛСР ао",@"ЛУКОЙЛ",@"Лензол. ап",@"Лензолото",@"Ленэнерг-п",@"Ленэнерго",@"М.видео",@"МБСП",@"МГТС-4ап",@"МГТС-5ао",@"МДМ Банк-п",@"МЕРИДИАН",@"МИКРОН ао",@"ММК",@"МН-фонд ао",@"МОЭСК",@"МРСК СЗ",@"МРСК СК",@"МРСК Ур",@"МРСК ЦП",@"МРСК Центр",@"МРСКВол",@"МРСКСиб",@"МРСКЮга ао",@"МТС-002D",@"МТС-ао",@"МФБ ао",@"МагадЭн ао",@"МагадЭн ап",@"Магнит ао",@"Мегион-ао",@"Мегион-ап",@"МежрегСГ",@"Мечел ао",@"Мечел ап",@"МордЭнСб",@"МосТСК ао",@"МосЭС ао",@"МоскНПЗ ао",@"Мостотрест",@"Мотовил ао",@"НКНХ ао",@"НКНХ ап",@"НЛМК ао",@"НМТП ао",@"НОМОС-Б ао",@"НижНФГЗ ао",@"НижгорСб",@"НижгорСб-п",@"Новатэк ао",@"Новопл ап",@"НутрИнвХол",@"ОГК-1 ao",@"ОГК-2 ао",@"ОГК-3 ао",@"ОГК-4 ао",@"ОГК-5 ао",@"ОГК-6 ао",@"ОМЗ-ао",@"ОМЗ-ап",@"ОМПК ао",@"ОПИН ао",@"ОбСибФ ао",@"Омскшина",@"ОптИнв ао",@"ПАВА ао",@"ПИК ао",@"ПМП ао",@"ПРОТЕК ао",@"ПермМот ао",@"ПермьЭнС-п",@"ПермьЭнСб",@"ПетербСК",@"Полиметалл",@"ПолюсЗолот",@"Приморье",@"ПроектИ ао",@"Промавт-ао",@"РБК ао",@"РОСИНВЕСТ",@"РОСИНТЕРао",@"РТМ ао",@"Разгуляй",@"Распадская",@"РегБР ао",@"Родина ап",@"Росбанк ао",@"Роснефть",@"Ростел -ао",@"Ростел -ап",@"Ростел002D",@"Ростел003D",@"Ростел004D",@"Ростел005D",@"Ростел006D",@"Ростел007D",@"Ростел008D",@"Ростел009D",@"Ростел010D",@"Ростел011D",@"Ростел012D",@"Ростел013D",@"Ростел014D",@"Ростел015D",@"Ростел016D",@"Ростел017D",@"РостовЭС",@"РостовЭС-п",@"РусГидр39D",@"РусГидро",@"Русал рдр",@"Русгрэйн",@"Русполимет",@"РуссМоре",@"РязЭнСб",@"СЗПароход",@"СМЗ-ао",@"СОЛЛЕРС",@"СТЗ-ао",@"СУМЗ ао",@"СУЭК-Красн",@"СЭМЗ ао",@"Сбербанк",@"Сбербанк-п",@"СвИнТх ао",@"СвердЭС ао",@"СвердЭС ап",@"СевСт-ао",@"Селестра",@"СилМашины",@"СинТЗ-ао",@"Синерг. ао",@"СистГалс",@"Система ао",@"Слав-ЯНОСп",@"Славн-ЯНОС",@"СтаврЭнСб",@"СтаврЭнСбп",@"Стратег ао",@"Сургнфгз",@"Сургнфгз-п",@"ТАГМЕТ ао",@"ТАМП ао",@"ТАТБЕНТОао",@"ТГК-1",@"ТГК-11",@"ТГК-13",@"ТГК-14",@"ТГК-2",@"ТГК-2 ап",@"ТГК-5",@"ТГК-6",@"ТГК-9",@"ТЗА ао",@"ТКСМ ао",@"ТМК ао",@"ТНК-ВР ао",@"ТНК-ВР ап",@"ТРАНСАЭРао",@"ТСК-1 ао",@"Таврическ.",@"ТамбЭнСб",@"ТамбЭнСб-п",@"Татнфт 3ао",@"Татнфт 3ап",@"Таттел. ао",@"Телеграф",@"ТомскРП ао",@"ТомскРП ап",@"ТрКред ао",@"ТрансК ао",@"Транснф ап",@"Туламаш ао",@"Туламаш ап",@"У-УАЗ ао",@"УАЗ ао",@"УКОРФ ао",@"УКСинергия",@"УдмуртЭС",@"УдмуртЭС-п",@"Уркалий 4D",@"Уркалий 5D",@"Уркалий-ао",@"ФЛК 01",@"ФСК ЕЭС ао",@"Фармстанд",@"ФинСерв ао",@"Фортум",@"ХолМРСК ао",@"ХолМРСК ап",@"ЦМТ ао",@"ЦМТ ап",@"ЦУМ-2",@"ЧКПЗ ао",@"ЧМК ао",@"ЧТПЗ ао",@"ЧЦЗ ао",@"ЧелябЭС ао",@"ЧелябЭС ап",@"ЧеркизГ-ао",@"ЭнерСбт ао",@"ЭнерСбт ап",@"ЭнергияРКК",@"ЭраВодолея",@"ЮТэйр ао",@"ЮжКузб. ао",@"Якутскэн-п",@"Якутскэнрг",@"ЯрШинЗ ао",@"Ярославич"};
static const NSString* EmitentCodes[]={@"MSNG",@"SCOH",@"ARMD",@"DZRD",@"DZRDP",@"DIOD",@"ISKJ",@"NEKK",@"ODVA",@"RNAV",@"LIFE",@"UTII",@"AVAZ",@"AVAZP",@"AGRE",@"RU14AVAN8010",@"UNAC",@"AZKM",@"AKRN",@"APDS",@"APDSP",@"RU14APTK1007",@"ARMD-002D",@"ARSA",@"ASSB",@"AMEZ",@"AFLT",@"BSPB",@"BSPBP",@"PKBA",@"PKBAP",@"MMBM",@"BISV",@"BISVP",@"BEGY",@"BELO",@"BACT",@"WBDF",@"VFRM",@"VSMZ",@"VTBR",@"VTGK",@"VLHZ",@"VDSB",@"VSMO",@"VZRZ",@"VZRZP",@"VGSB",@"VGSBP",@"VOSB",@"VRAO",@"RAOVP",@"GAZP",@"GMKN",@"SNOS",@"RU0008913751",@"SIBN",@"FESH",@"DIKO",@"DIXY",@"DVEC",@"DASB",@"DLVB",@"DLVBP",@"DNKOP",@"DGBZ",@"DGBZP",@"ERMK",@"ZIRE",@"ZMZN",@"ZMZNP",@"ZOYA",@"IRKT",@"IKAR",@"IUES-002D",@"IUES",@"IRGZ",@"KMAZ",@"KZMS",@"KMEZ",@"KUOS",@"KTSB",@"KTSBP",@"KHEL",@"KLNA",@"KLSB",@"KDSK",@"KCHE",@"KCHEP",@"TGKD",@"TGKDP",@"KISB",@"KISBP",@"KSGR",@"KOSB",@"KOGK",@"RU0008913868",@"KROT",@"KRSG",@"KRSB",@"KRSBP",@"KUSTP",@"KBSB",@"KUBE",@"KBTK",@"KZBN",@"LSRG",@"LKOH",@"LNZLP",@"LNZL",@"LSNGP",@"LSNG",@"MVID",@"RU14MBSP7002",@"RU14MGTS2012",@"RU14MGTS5007",@"MDMBP",@"MERF",@"MIKR",@"MAGN",@"MNFD",@"MSRS",@"MRKZ",@"MRKK",@"MRKU",@"MRKP",@"MRKC",@"MRKV",@"MRKS",@"MRKA",@"MTSI-002D",@"MTSI",@"MFBA",@"MAGE",@"MAGEP",@"MGNT",@"RU0009011126",@"RU0009011134",@"IRSG",@"MTLR",@"MTLRP",@"MRSB",@"MSSV",@"MSSB",@"MNPZ",@"MSTT",@"MOTZ",@"NKNC",@"NKNCP",@"NLMK",@"NMTP",@"NMOS",@"RU14NZGZ2006",@"NNSB",@"NNSBP",@"NOTK",@"SXPNP",@"NTRI",@"OGK1",@"OGK2",@"OGKC",@"OGK4",@"OGKE",@"OGK6",@"OMZZ",@"OMZZP",@"OSMP",@"OPIN",@"OSFD",@"OMSH",@"OPTI",@"AKHA",@"PIKK",@"PRIM",@"PRTK",@"PMOT",@"PMSBP",@"PMSB",@"PBSB",@"PMTL",@"PLZL",@"PRMB",@"PRIN",@"NPE1",@"RBCM",@"RVST",@"ROST",@"RTMC",@"GRAZ",@"RASP",@"REBR",@"RODNP",@"ROSB",@"ROSN",@"RTKM",@"RTKMP",@"RTKM-002D",@"RTKM-003D",@"RTKM-004D",@"RTKM-005D",@"RTKM-006D",@"RTKM-007D",@"RTKM-008D",@"RTKM-009D",@"RTKM-010D",@"RTKM-011D",@"RTKM-012D",@"RTKM-013D",@"RTKM-014D",@"RTKM-015D",@"RTKM-016D",@"RTKM-017D",@"RTSB",@"RTSBP",@"HYDR-039D",@"HYDR",@"RUALR",@"RUGR",@"RUSP",@"RSEA",@"RZSB",@"SZPR",@"MGNZ",@"SVAV",@"SVTZ",@"SUMZ",@"SKRN",@"SEMZ",@"SBER",@"SBERP",@"SOVT",@"SVSB",@"SVSBP",@"CHMF",@"SELL",@"SILM",@"SNTZ",@"SYNG",@"HALS",@"AFKC",@"JNOSP",@"JNOS",@"STSB",@"STSBP",@"YKST",@"SNGS",@"SNGSP",@"TAMZ",@"TGMK",@"TATB",@"TGKA",@"TGKK",@"TGK13",@"TGKN",@"TGKB",@"TGKBP",@"TGKE",@"TGKF",@"TGKI",@"TUZA",@"TUCH",@"TRMK",@"TNBP",@"TNBPP",@"TAER",@"TSKA",@"TAVR",@"TASB",@"TASBP",@"TATN",@"TATNP",@"TTLK",@"CNTL",@"TORS",@"TORSP",@"TCBN",@"TRCN",@"TRNFP",@"TUMA",@"TUMAP",@"UUAZ",@"UAZA",@"URFD",@"USYN",@"UDSB",@"UDSBP",@"URKA-004D",@"URKA-005D",@"URKA",@"FLKO",@"FEES",@"PHST",@"FSRV",@"TGKJ",@"MRKH",@"MRKHP",@"WTCM",@"WTCMP",@"TZUM",@"CHKZ",@"CHMK",@"CHEP",@"CHZN",@"CLSB",@"CLSBP",@"GCHE",@"NGSB",@"NGSBP",@"RKKE",@"ERAV",@"UTAR",@"UKUZ",@"YKENP",@"YKEN",@"YASH",@"YRSL"};
//------------------------------------------------Main Functions-------------------------------------------------------------
+(NSMutableArray*)getEmitentCodes{
    NSMutableArray* array=[[NSMutableArray alloc] init];
    for(int i=0;i<316;i++)
        [array addObject:EmitentCodes[i]];
    return array;
}
+(void)getDataForChart:(NSString*)instrumentCode:(NSDate*)start:(QuotationType)bidType:(void(^)(Quotation*))handler{
    NSDictionary* args = [NSDictionary dictionaryWithObjectsAndKeys:
        instrumentCode, @"instrumentCode", start, @"start", [NSNumber numberWithInt:bidType], @"bidType", handler, @"handler", nil];
    [MICEX_Loader performSelectorInBackground:@selector(runDataForChart:) withObject:args];    
}
+(void)runDataForChart:(NSDictionary*)args{
    NSString* instrumentCode=[args objectForKey:@"instrumentCode"];
    Instrument* instrument=[MICEX_Loader getInstrumentByCode:instrumentCode];
    HistoryLoader* loader=[HistoryLoader newHistoryLoader];
    [Settings setBoardCode:[instrument board]];
    QuotationType bidType=[(NSNumber*)[args objectForKey:@"bidType"] intValue];
    [loader load:EmitentMarket:[MICEX_Loader getInstrumentId:instrumentCode]:instrumentCode:[args objectForKey:@"start"]:bidType];
    [MICEX_Loader getCurrentValueAsync:[instrument board]:instrumentCode:bidType:[args objectForKey:@"handler"]];
}
+(void)getCurrentValueAsync:(NSString*)board:(NSString*)instrumentCode:(QuotationType)bidType:(void(^)(Quotation*))handler{
    NSDictionary* args = [NSDictionary dictionaryWithObjectsAndKeys:
                          instrumentCode, @"instrumentCode", board, @"board", [NSNumber numberWithInt:bidType], @"bidType", handler, @"handler", nil];
    [MICEX_Loader performSelectorInBackground:@selector(runCurrentValue:) withObject:args];
}
+(void)runCurrentValue:(NSDictionary*)args{
    NSString *board=[args objectForKey:@"board"],
            *instrumentCode=[args objectForKey:@"instrumentCode"];
    QuotationType bidType=[(NSNumber*)[args objectForKey:@"bidType"] intValue];
    NSString* query=[[NSString alloc] initWithFormat:@"http://www.micex.ru/iss/engines/stock/markets/shares/boards/%@/securities/%@.xml?iss.meta=off&iss.only=marketdata&marketdata.columns=LAST,TIME", board, instrumentCode];//,SECID,HIGH,LOW,OPEN,LASTCHANGE,CLOSEPRICE,SYSTIME,SEQNUM";
    NSLog(@"%@", query);
    NSArray *rows = PerformXMLXPathQuery([NSData dataWithContentsOfURL:[NSURL URLWithString:query]], @"//row");
    id row=[rows objectAtIndex:0];
    NSMutableDictionary *attributes=[MICEX_Loader getAttributes:row];
    NSString* price=[attributes objectForKey:@"LAST"];
    NSString* date=[attributes objectForKey:@"TIME"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate* dateObj=[formatter dateFromString:date];
    Quotation* q=[Quotation newQuotation:[price doubleValue]:dateObj:bidType];
    void (^handler)(Quotation*)=[args objectForKey:@"handler"];
    handler(q);    
}
+(double)getCurrentValue:(NSString*)board:(NSString*)instrumentCode{		
    if(board==@""){
        Instrument* instr=[MICEX_Loader getInstrumentByCode:instrumentCode];
        board=[instr board];
    }
    NSString* query=[NSString stringWithFormat:@"http://www.micex.ru/iss/engines/stock/markets/shares/boards/%@/securities/%@.xml?iss.meta=off&iss.only=marketdata&marketdata.columns=LAST", board, instrumentCode];//TIME,SECID,HIGH,LOW,OPEN,LASTCHANGE,CLOSEPRICE,SYSTIME,SEQNUM";
    NSArray *rows = PerformXMLXPathQuery([NSData dataWithContentsOfURL:[NSURL URLWithString:query]], @"//row");
    NSMutableDictionary *attributes=[MICEX_Loader getAttributes:[rows objectAtIndex:0]];
    NSString* price=[attributes objectForKey:@"LAST"];				
    return [price doubleValue];				
}
//--------------------------------------Help Functions-------------------------------------------------------
+(Instrument*)getInstrumentByCode:(NSString*)code{		
    NSString* query=[NSString stringWithFormat:@"http://www.micex.ru/iss/securities/%@.xml?iss.meta=off&iss.only=boards&boards.columns=secid,boardid,title", code];
    NSLog(@"query: %@", query);
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:query]];
    NSArray *rows = PerformXMLXPathQuery(data, @"//row");
    id row=[rows objectAtIndex:0];
    NSMutableDictionary *attributes=[MICEX_Loader getAttributes:row];
    Instrument* instrument=[Instrument newInstrument:[Instrument getMICEX]:[attributes objectForKey:@"boardid"]:[attributes objectForKey:@"secid"]:[attributes objectForKey:@"title"]:0];    
    return instrument;
}
+(NSMutableDictionary*)getAttributes:(id)row{
    NSArray* attributes=[row objectForKey:@"nodeAttributeArray"];
    NSMutableDictionary* result=[[NSMutableDictionary alloc] init];
    for(int i=0;i<attributes.count;i++)
        [result setObject:[[attributes objectAtIndex:i] objectForKey:@"nodeContent"] forKey:[[attributes objectAtIndex:i] objectForKey:@"attributeName"]];
    return result;
}
+(int)getInstrumentId:(NSString*)instrumentCode{  
    int size=sizeof(EmitentIds)/sizeof(int);
    for(int i=0;i<size;i++){
        if([instrumentCode isEqualToString:EmitentCodes[i]])
            return EmitentIds[i];
    }
    return 0;
}
@end
