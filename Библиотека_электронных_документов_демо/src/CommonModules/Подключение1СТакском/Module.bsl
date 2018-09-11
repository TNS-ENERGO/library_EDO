
////////////////////////////////////////////////////////////////////////////////
// Подсистема "Подключение 1С-Такском".
// ОбщийМодуль.Подключение1СТакском.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Добавляет описание обработчиков событий, реализуемых подсистемой.
//
// Описание формата процедур-обработчиков см. в описании функции
// ИнтернетПоддержкаПользователейСлужебныйПовтИсп.ОбработчикиСобытий().
//
// Параметры:
//	СерверныеОбработчики - Структура - серверные обработчики;
//		* ПараметрыРаботыКлиентаПриЗапуске - Массив - элементы типа Строка -
//			имена модулей, реализующих обработку заполнения параметров
//			работы клиента при запуске;
//		* ОчиститьНастройкиИПППользователя - элементы типа Строка -
//			имена модулей, реализующих обработку очистки настроек
//			пользователя при выходе авторизованного пользователя из ИПП;
//		* БизнесПроцессы - Соответствие - серверные обработчики
//			бизнес-процессов:
//			** Ключ - Строка - точка входа бизнес-процесса;
//			** Значение - Строка - имя серверного модуля, реализующего
//				обработчик бизнес-процесса;
//	КлиентскиеОбработчики - Структура - клиентские обработчики;
//		* ПриНачалеРаботыСистемы - элементы типа Строка -
//			имена клиентских модулей, реализующих обработку
//			события "При начале работы системы"
//		* БизнесПроцессы - Соответствие - клиентские обработчики
//			бизнес-процессов:
//			** Ключ - Строка - точка входа бизнес-процесса;
//			** Значение - Строка - имя клиентского модуля, реализующего
//				обработчик бизнес-процесса;
//
Процедура ДобавитьОбработчикиСобытий(СерверныеОбработчики, КлиентскиеОбработчики) Экспорт
	
	БизнесПроцессыСервер = СерверныеОбработчики.БизнесПроцессы;
	
	БизнесПроцессыСервер.Вставить("taxcomGetID\ПараметрыСозданияКонтекста",
		"Подключение1СТакском");
	БизнесПроцессыСервер.Вставить("taxcomGetID\ОпределитьВозможностьЗапуска",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыСервер.Вставить("taxcomGetID\ПриСозданииКонтекстаВзаимодействия",
		"Подключение1СТакском");
	БизнесПроцессыСервер.Вставить("taxcomGetID\КонтекстВыполненияКоманды",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыСервер.Вставить("taxcomGetID\ВыполнитьКомандуСервиса",
		"Подключение1СТакском");
	БизнесПроцессыСервер.Вставить("taxcomGetID\СтруктурироватьКомандуСервиса",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыСервер.Вставить("taxcomGetID\ЗаполнитьПараметрыВнутреннейФормы",
		"Подключение1СТакскомКлиентСервер");
	
	БизнесПроцессыСервер.Вставить("taxcomPrivat\ПараметрыСозданияКонтекста",
		"Подключение1СТакском");
	БизнесПроцессыСервер.Вставить("taxcomPrivat\ОпределитьВозможностьЗапуска",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыСервер.Вставить("taxcomPrivat\ПриСозданииКонтекстаВзаимодействия",
		"Подключение1СТакском");
	БизнесПроцессыСервер.Вставить("taxcomPrivat\КонтекстВыполненияКоманды",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыСервер.Вставить("taxcomPrivat\ВыполнитьКомандуСервиса",
		"Подключение1СТакском");
	БизнесПроцессыСервер.Вставить("taxcomPrivat\СтруктурироватьКомандуСервиса",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыСервер.Вставить("taxcomPrivat\ЗаполнитьПараметрыВнутреннейФормы",
		"Подключение1СТакскомКлиентСервер");
	
	БизнесПроцессыКлиент = КлиентскиеОбработчики.БизнесПроцессы;
	
	БизнесПроцессыКлиент.Вставить("taxcomGetID\КонтекстВыполненияКоманды",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыКлиент.Вставить("taxcomGetID\ВыполнитьКомандуСервиса",
		"Подключение1СТакскомКлиент");
	БизнесПроцессыКлиент.Вставить("taxcomGetID\ПараметрыОткрытияФормы",
		"Подключение1СТакскомКлиент");
	БизнесПроцессыКлиент.Вставить("taxcomGetID\СтруктурироватьКомандуСервиса",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыКлиент.Вставить("taxcomGetID\ЗаполнитьПараметрыВнутреннейФормы",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыКлиент.Вставить("taxcomGetID\ПередОткрытиемФормы",
		"Подключение1СТакскомКлиент");
	
	БизнесПроцессыКлиент.Вставить("taxcomPrivat\КонтекстВыполненияКоманды",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыКлиент.Вставить("taxcomPrivat\ВыполнитьКомандуСервиса",
		"Подключение1СТакскомКлиент");
	БизнесПроцессыКлиент.Вставить("taxcomPrivat\ПараметрыОткрытияФормы",
		"Подключение1СТакскомКлиент");
	БизнесПроцессыКлиент.Вставить("taxcomPrivat\СтруктурироватьКомандуСервиса",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыКлиент.Вставить("taxcomPrivat\ЗаполнитьПараметрыВнутреннейФормы",
		"Подключение1СТакскомКлиентСервер");
	БизнесПроцессыКлиент.Вставить("taxcomPrivat\ПередОткрытиемФормы",
		"Подключение1СТакскомКлиент");
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработка бизнес-процессов

// Вызывается при заполнении параметров создания контекста бизнес-процесса.
// См. процедуру ИнтернетПоддержкаПользователейВызовСервера.ПараметрыСозданияКонтекста().
//
// Параметры:
//	Параметры - Структура - предзаполненные параметры:
//	* МестоЗапуска - Строка - точка входа бизнес-процесса;
//	* ПриНачалеРаботыСистемы - Булево - Истина, если запуск бизнес-процесса
//		выполняется при начале работы системы;
//	* ИспользоватьИнтернетПоддержку - Булево - Истина, если разрешено
//		использование ИПП для текущего режима работы ИБ;
//	* ЗапускРазрешен - Булево - Истина, если текущему пользователю разрешен
//		запуск ИПП;
//	ПрерватьОбработку - Булево - в параметре возвращается признак завершения
//		дальнейшей обработки, если известно, что дальнейшая обработка не
//		требуется.
//
Процедура ПараметрыСозданияКонтекста(Параметры, ПрерватьОбработку) Экспорт
	
	Параметры.Вставить("ИспользоватьПодключение1СТакском", Истина);
	Если НЕ Параметры.ИспользоватьПодключение1СТакском Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Пользователи.РолиДоступны("ИспользованиеСервиса1СТакском", , Ложь) Тогда
		Параметры.ЗапускРазрешен = Ложь;
	КонецЕсли;
	
КонецПроцедуры

// Добавляет необходимые параметры к созданному контексту выполнения
// бизнес-процесса.
//
// Параметры:
//	Контекст - см. функцию
//		ИнтернетПоддержкаПользователейВызовСервера.НовыйКонтекстВзаимодействия()
Процедура ПриСозданииКонтекстаВзаимодействия(Контекст) Экспорт
	
	МестоЗапуска = Контекст.КСКонтекст.ОсновныеПараметры.МестоЗапуска;
	Если МестоЗапуска = "taxcomGetID" Тогда
		Контекст.Вставить("СообщениеОНедоступностиДействия",
			НСтр("ru = 'Получение уникального идентификатора абонента Такском недоступно для этой конфигурации.'"));
	ИначеЕсли МестоЗапуска = "taxcomPrivat" Тогда
		Контекст.Вставить("СообщениеОНедоступностиДействия",
			НСтр("ru = 'Работа с личным кабинетом абонента Такском недоступна для этой конфигурации.'"));
	КонецЕсли;
	
КонецПроцедуры

// Выполнение команды сервиса ИПП на стороне сервера 1С:Предприятия.
// Параметры:
//	КСКонтекст - см. описание функции
//		ИнтернетПоддержкаПользователейВызовСервера.НовыйКонтекстВзаимодействия();
//	СтруктураКоманды - см. описание функции
//		ИнтернетПоддержкаПользователейКлиентСервер.СтруктурироватьОтветСервера();
//	КонтекстОбработчика - см. описание функции
//		ИнтернетПоддержкаПользователейКлиентСервер.НовыйКонтекстОбработчикаКоманд().
//
Процедура ВыполнитьКомандуСервиса(КСКонтекст, СтруктураКоманды, КонтекстОбработчика) Экспорт
	
	ИмяКоманды = СтруктураКоманды.ИмяКоманды;
	Если ИмяКоманды = "performtheaction.getcertificate" Тогда
		ПодготовитьСертификатЭПкОтправке(КСКонтекст, КонтекстОбработчика);
		
	ИначеЕсли ИмяКоманды = "performtheaction.getinformationaboutorganization" Тогда
		ПодготовитьДанныеОбОрганизации(КСКонтекст, КонтекстОбработчика);
		
	ИначеЕсли ИмяКоманды = "performtheaction.findcertificatefingerprint" Тогда
		ПодготовитьДанныеСертификатаПоОтпечатку(КСКонтекст, КонтекстОбработчика);
		
	ИначеЕсли ИмяКоманды = "setcodesregion" Тогда
		Подключение1СТакскомКлиентСервер.СохранитьВПараметрахКодыРегионов(КСКонтекст, СтруктураКоманды);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает двоичные данные сертификата.
//
// Параметры:
//	Сертификат - СправочникСсылка.СертификатыКлючейЭлектроннойПодписиИШифрования
//		ссылка справочника сертификатов.
//
// Возвращаемое значение:
//	ДвоичныеДанные - двоичные данные сертификата;
//	Неопределено - если сертификат не обнаружен в справочнике сертификатов.
//
Функция ДвоичныеДанныеСертификата(Сертификат) Экспорт
	
	ДанныеСертификата = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Сертификат, "ДанныеСертификата");
	Возврат ?(ДанныеСертификата = Неопределено, Неопределено, ДанныеСертификата.Получить());
	
КонецФункции

// Возвращает ссылку на элемент справочника сертификатов по отпечатку
// сертификата.
//
// Параметры:
//	Отпечаток - Строка - отпечаток сертификата;
//
// Возвращаемое значение:
//	СправочникСсылка.СертификатыКлючейЭлектроннойПодписиИШифрования - ссылка
//		на найденный по отпечатку сертификат;
//	Неопределено - если сертификат не найден по отпечатку.
//
Функция НайтиСертификатПоОтпечатку(Отпечаток)
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	СертификатыКлючейЭлектроннойПодписиИШифрования.Ссылка
	|ИЗ
	|	Справочник.СертификатыКлючейЭлектроннойПодписиИШифрования КАК СертификатыКлючейЭлектроннойПодписиИШифрования
	|ГДЕ
	|	СертификатыКлючейЭлектроннойПодписиИШифрования.Отпечаток = &Отпечаток");
	
	Запрос.УстановитьПараметр("Отпечаток", Отпечаток);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Возврат ?(Выборка.Следующий(), Выборка.Ссылка, Неопределено);
	
КонецФункции

// Записывает в сессионные параметры контекста двоичные данные сертификата пользователя в
//	виде Base64-строки.
//
Процедура ПодготовитьСертификатЭПКОтправке(КСКонтекст, КонтекстОбработчика)
	
	// При старте механизма сертификат был записан в виде строки внутреннего представления
	// в регистр как стартовый параметр ЭД в процедуре СохранитьСтартовыеПараметрыЭД.
	
	// Получение ссылки сертификата и его двоичных данных
	СертификатЭП = ИнтернетПоддержкаПользователейКлиентСервер.ЗначениеСессионногоПараметра(
		КСКонтекст,
		"IDCertificateED");
	
	Если СертификатЭП = Неопределено Тогда
		
		КонтекстОбработчика.ПроизошлаОшибка = Истина;
		КонтекстОбработчика.ПользовательскоеОписаниеОшибки =
			НСтр("ru = 'Не удалось получить двоичные данные сертификата. Сертификат не обнаружен в списке параметров.'");
		КонтекстОбработчика.ДействиеПриОшибкеДляКлиента = "ПоказатьСообщение";
		КонтекстОбработчика.ДействияПриОшибкеДляСервера.Добавить("ПрерватьБизнесПроцесс");
		Возврат;
		
	КонецЕсли;
	
	ДвоичныеДанныеСертификата = ДвоичныеДанныеСертификата(СертификатЭП);
	Если ДвоичныеДанныеСертификата = Неопределено Тогда
		
		СообщениеДляЖурналаРегистрации = НСтр("ru = 'Ошибка при получении двоичных данных сертификата. Двоичные данные сертификата отсутствуют, либо сертификат был удален.'");
		ИнтернетПоддержкаПользователейВызовСервера.ЗаписатьОшибкуВЖурналРегистрации(
			СообщениеДляЖурналаРегистрации, СертификатЭП);
		
		КонтекстОбработчика.ПроизошлаОшибка                = Истина;
		КонтекстОбработчика.ПолноеОписаниеОшибки           = СообщениеДляЖурналаРегистрации;
		КонтекстОбработчика.ДействияПриОшибкеДляСервера.Добавить("СоздатьЗаписьВЖурналеРегистрации");
		КонтекстОбработчика.ДействияПриОшибкеДляСервера.Добавить("ПрерватьБизнесПроцесс");
		КонтекстОбработчика.ПользовательскоеОписаниеОшибки =
			НСтр("ru = 'Ошибка при получении данных сертификата. Подробнее см. в журнале регистрации.'");
		КонтекстОбработчика.ДействиеПриОшибкеДляКлиента = "ПоказатьСообщение";
		Возврат;
		
	КонецЕсли;
	
	// Запись в регистр двоичных данных сертификата для отправки на сервер
	СтрокаBase64 = Base64Строка(ДвоичныеДанныеСертификата);
	
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(
		КСКонтекст,
		"certificateED",
		СтрокаBase64);
	
КонецПроцедуры

// Подготавливает и сохраняет в сессионных параметрах сведения об организации.
//
Процедура ПодготовитьДанныеОбОрганизации(КСКонтекст, КонтекстОбработчика)
	
	// При старте механизма ссылка на организацию была записана в виде строки
	// внутреннего представления как стартовый параметр ЭД.
	
	Организация = ИнтернетПоддержкаПользователейКлиентСервер.ЗначениеСессионногоПараметра(КСКонтекст,
		"IDOrganizationED");
	
	Если Организация = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураДанныхОбОрганизации = Новый Структура;
	
	Попытка
		Подключение1СТакскомПереопределяемый.ЗаполнитьРегистрационныеДанныеОрганизации(
			Организация,
			СтруктураДанныхОбОрганизации);
	Исключение
		
		КонтекстОбработчика.ПроизошлаОшибка = Истина;
		КонтекстОбработчика.ПолноеОписаниеОшибки =
			НСтр("ru = 'Не удалось получить регистрационные данные организации.'")
			+ " " + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		КонтекстОбработчика.ДействияПриОшибкеДляСервера.Добавить("СоздатьЗаписьВЖурналеРегистрации");
		КонтекстОбработчика.ДействияПриОшибкеДляСервера.Добавить("ПрерватьБизнесПроцесс");
		
		КонтекстОбработчика.ПользовательскоеОписаниеОшибки =
			НСтр("ru = 'Ошибка при получении данных организации.
				 |Подробнее см. в журнале регистрации'");
		КонтекстОбработчика.ДействиеПриОшибкеДляКлиента = "ПоказатьСообщение";
		Возврат;
		
	КонецПопытки;
	
	Если СтруктураДанныхОбОрганизации = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Индекс          = "";
	Регион          = "";
	Район           = "";
	Город           = "";
	НаселенныйПункт = "";
	Улица           = "";
	Дом             = "";
	Корпус          = "";
	Квартира        = "";
	Телефон         = "";
	Наименование    = "";
	ИНН             = "";
	КПП             = "";
	ОГРН            = "";
	КодИМНС         = "";
	ЮрФизЛицо       = "";
	Фамилия         = "";
	Имя             = "";
	Отчество        = "";
	
	СтруктураДанныхОбОрганизации.Свойство("Индекс"         , Индекс);
	СтруктураДанныхОбОрганизации.Свойство("Регион"         , Регион);
	СтруктураДанныхОбОрганизации.Свойство("Район"          , Район);
	СтруктураДанныхОбОрганизации.Свойство("Город"          , Город);
	СтруктураДанныхОбОрганизации.Свойство("НаселенныйПункт", НаселенныйПункт);
	СтруктураДанныхОбОрганизации.Свойство("Улица"          , Улица);
	СтруктураДанныхОбОрганизации.Свойство("Дом"            , Дом);
	СтруктураДанныхОбОрганизации.Свойство("Корпус"         , Корпус);
	СтруктураДанныхОбОрганизации.Свойство("Квартира"       , Квартира);
	СтруктураДанныхОбОрганизации.Свойство("Телефон"        , Телефон);
	СтруктураДанныхОбОрганизации.Свойство("Наименование"   , Наименование);
	СтруктураДанныхОбОрганизации.Свойство("ИНН"            , ИНН);
	СтруктураДанныхОбОрганизации.Свойство("КПП"            , КПП);
	СтруктураДанныхОбОрганизации.Свойство("ОГРН"           , ОГРН);
	СтруктураДанныхОбОрганизации.Свойство("КодИМНС"        , КодИМНС);
	СтруктураДанныхОбОрганизации.Свойство("ЮрФизЛицо"      , ЮрФизЛицо);
	СтруктураДанныхОбОрганизации.Свойство("Фамилия"        , Фамилия);
	СтруктураДанныхОбОрганизации.Свойство("Имя"            , Имя);
	СтруктураДанныхОбОрганизации.Свойство("Отчество"       , Отчество);
	
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "postindexED", Индекс);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "addressregionED", Регион);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "addresscoderegionED", "");
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст,
		"addresstownshipED",
		Район);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "addresscityED", Город);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст,
		"addresslocalityED",
		НаселенныйПункт);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "addressstreetED", Улица);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "addressbuildingED", Дом);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст,
		"addresshousingED",
		Корпус);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст,
		"addressapartmentED",
		Квартира);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "addressphoneED", Телефон);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "agencyED", Наименование);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "orgindED", ЮрФизЛицо);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "innED", ИНН);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "kppED", КПП);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "ogrnED", ОГРН);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "codeimnsED", КодИМНС);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "lastnameED", Фамилия);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "firstnameED", Имя);
	ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(КСКонтекст, "middlenameED", Отчество);
	
КонецПроцедуры

// Поиск сертификата по отпечатку, хранимому в сессионных параметрах
// и запись ссылки а сертификат в сессионные параметры.
//
Процедура ПодготовитьДанныеСертификатаПоОтпечатку(КСКонтекст, КонтекстОбработчика)
	
	// Отпечаток сертификата должен быть передан в сессионные параметры
	
	ОтпечатокСертификата = ИнтернетПоддержкаПользователейКлиентСервер.ЗначениеСессионногоПараметра(
		КСКонтекст,
		"certificatefingerprintED");
	
	СертификатЭП = Неопределено;
	Если ОтпечатокСертификата <> Неопределено Тогда
		СертификатЭП = НайтиСертификатПоОтпечатку(ОтпечатокСертификата);
	КонецЕсли;
	
	Если СертификатЭП <> Неопределено Тогда
		ИнтернетПоддержкаПользователейКлиентСервер.ЗаписатьПараметрКонтекста(
			КСКонтекст,
			"IDCertificateED",
			СертификатЭП);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти