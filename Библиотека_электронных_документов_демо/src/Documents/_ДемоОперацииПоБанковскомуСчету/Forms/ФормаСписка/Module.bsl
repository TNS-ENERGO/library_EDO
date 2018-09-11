#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

&НаКлиенте
Перем ФормаДлительнойОперации;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ВходящийОтборПоОрганизации = Ложь;
	СтруктураОтбора = Неопределено;
	Если Параметры.Свойство("Отбор", СтруктураОтбора) И ТипЗнч(СтруктураОтбора) = Тип("Структура") Тогда
		ВходящийОтборПоОрганизации = СтруктураОтбора.Свойство("Организация", ОтборОрганизация);
		СтруктураОтбора.Свойство("СчетОрганизации", ОтборСчетОрганизации);
		
		ОтборОрганизацияИспользование    = ЗначениеЗаполнено(ОтборОрганизация);
		ОтборСчетОрганизацииИспользование = ЗначениеЗаполнено(ОтборСчетОрганизации);
	КонецЕсли;
	
	ОсновнаяОрганизация = Справочники.Организации.ОрганизацияПоУмолчанию();
	
	Если НЕ ВходящийОтборПоОрганизации И ОтборОрганизация <> ОсновнаяОрганизация Тогда
		ОтборОрганизация                 = ОсновнаяОрганизация;
		УстановитьБанковскийСчетОрганизации(ОтборСчетОрганизации, ОтборОрганизация);
		ОтборОрганизацияИспользование    = ЗначениеЗаполнено(ОтборОрганизация);
		ОтборСчетОрганизацииИспользование = ЗначениеЗаполнено(ОтборСчетОрганизации);
	КонецЕсли;	
	
	УстановитьВосстановленныеОтборы();

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	ВыпискиБанка.Очистить();

	Если ТипЗнч(ВыбранноеЗначение) = Тип("ДокументСсылка.СообщениеОбменСБанками") Тогда
		
		ВыпискиБанка.Добавить(ВыбранноеЗначение);
		МассивВыписок = ВыпискиБанка.ВыгрузитьЗначения();
		АдресФайла    = ПолучитьДанныеВыпискиБанкаВФайл(МассивВыписок);
		
		ПрочитатьФайлВыпискиНаКлиенте(Новый ОписаниеПередаваемогоФайла(,АдресФайла));
		
	ИначеЕсли ТипЗнч(ВыбранноеЗначение) = Тип("Массив") И ВыбранноеЗначение.Количество() > 0 Тогда
		
		ВыпискиБанка.ЗагрузитьЗначения(ВыбранноеЗначение);
		Если ВыпискиБанка.Количество() > 0 Тогда
			МассивВыписок = ВыпискиБанка.ВыгрузитьЗначения();
			АдресФайла    = ПолучитьДанныеВыпискиБанкаВФайл(МассивВыписок);
			ПрочитатьФайлВыпискиНаКлиенте(Новый ОписаниеПередаваемогоФайла(,АдресФайла));
		КонецЕсли;
		
	КонецЕсли;

	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	Перем ОтборПоОрганизации, ОтборПоСчету, ОтборПоДате, ОтборПоКонтрагенту, ОтборПоНазначению;
	
	СтруктураОтбора = Неопределено;
	Если Параметры.Свойство("Отбор", СтруктураОтбора) И ЗначениеЗаполнено(СтруктураОтбора) Тогда
		
		Если СтруктураОтбора.Свойство("Организация") И ЗначениеЗаполнено(СтруктураОтбора.Организация) Тогда
			ОтборОрганизация = СтруктураОтбора.Организация;
			ОтборОрганизацияИспользование = ЗначениеЗаполнено(ОтборОрганизация);
		КонецЕсли;
		
		Если СтруктураОтбора.Свойство("СчетОрганизации") И ЗначениеЗаполнено(СтруктураОтбора.СчетОрганизации) Тогда
			ОтборСчетОрганизации = СтруктураОтбора.СчетОрганизации;
			ОтборСчетОрганизацииИспользование = ЗначениеЗаполнено(ОтборСчетОрганизации);
		КонецЕсли;
		
		Параметры.Отбор = Неопределено;
		
	Иначе
		Если ОтборОрганизация <> ОсновнаяОрганизация Тогда
			ОтборОрганизация  = ОсновнаяОрганизация;
			
			// Предварительно сбросим сохраненный банковский счет, т.к. он не принадлежит текущей организации
			// и может быть проблема при RLS.
			ОтборСчетОрганизации = Справочники.БанковскиеСчета.ПустаяСсылка();
			
			УстановитьБанковскийСчетОрганизации(ОтборСчетОрганизации, ОтборОрганизация);
			ОтборОрганизацияИспользование    = ЗначениеЗаполнено(ОтборОрганизация);
			ОтборСчетОрганизацииИспользование = ЗначениеЗаполнено(ОтборСчетОрганизации);
		ИначеЕсли НЕ ОтборОрганизацияИспользование Тогда
			ОтборОрганизацияИспользование = ЗначениеЗаполнено(ОтборОрганизация);
		КонецЕсли;
	КонецЕсли;
	
	УстановитьВосстановленныеОтборы();
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОтборОрганизацияПриИзменении(Элемент)
	
	ОтборОрганизацияПриИзмененииСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборСчетОрганизацииПриИзменении(Элемент)
	
	ОтборСчетОрганизацииИспользование = ЗначениеЗаполнено(ОтборСчетОрганизации);
	ОтборБанковскийСчетПриИзмененииСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборСчетОрганизацииНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПараметрыФормы = Новый Структура();
	Отбор = Новый Структура();
	Если ЗначениеЗаполнено(ОтборОрганизация) Тогда  
		Отбор.Вставить("Владелец", ОтборОрганизация);
	КонецЕсли;
	Отбор.Вставить("ТипВладельцаСтрокой",	"СправочникСсылка.Организации");
	ПараметрыФормы.Вставить("Отбор", Отбор);
	ОткрытьФорму("Справочник.БанковскиеСчета.ФормаВыбора", ПараметрыФормы, Элемент,,,,);
	
КонецПроцедуры


&НаКлиенте
Процедура ОтборСчетОрганизацииИспользованиеПриИзменении(Элемент)
	
	УстановитьБыстрыйОтбор("СчетОрганизации");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборОрганизацияИспользованиеПриИзменении(Элемент)
	
	УстановитьБыстрыйОтбор("Организация");
	
	Если ОтборОрганизацияИспользование Тогда
		Если НЕ ОтборСчетОрганизацииИспользование И ЗначениеЗаполнено(ОтборСчетОрганизации) Тогда
			ОтборСчетОрганизацииИспользование = Истина;
			УстановитьБыстрыйОтбор("СчетОрганизации");
		КонецЕсли;
		
	ИначеЕсли ОтборСчетОрганизацииИспользование Тогда
		ОтборСчетОрганизацииИспользование = Ложь;
		УстановитьБыстрыйОтбор("СчетОрганизации");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗагрузитьИзБанка(Команда)
	
	Организация    = ?(ОтборОрганизацияИспользование,    ОтборОрганизация,    Неопределено);
	БанковскийСчет = ?(ОтборСчетОрганизацииИспользование, ОтборСчетОрганизации, Неопределено);
	ЗагрузитьВыписку(Организация, БанковскийСчет);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбменСБанком(Команда)
	
	ОткрытьФормуЗагрузкиИРазбораВыписки();	
	
КонецПроцедуры	

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ЗагрузкаВыписки

&НаКлиенте
Процедура ЗагрузитьВыписку(Организация, БанковскийСчет)
	
	НастройкаОбменаСБанком  = Неопределено;
	
	СтруктураНастроек = ПолучитьНастройкуОбменаСБанком(Организация, БанковскийСчет);
	Если ЗначениеЗаполнено(БанковскийСчет) Тогда
		
		СтруктураНастроек.Вставить("ЕстьПрямойОбменСБанками",
			ЗначениеЗаполнено(СтруктураНастроек.НастройкаОбменаСБанком));
	Иначе
		СтруктураНастроек.Вставить("ЕстьПрямойОбменСБанками", НастройкиОбмена().Количество() > 0);
	КонецЕсли;
	
	Если НЕ СтруктураНастроек.ЕстьПрямойОбменСБанками Тогда
		
		ТекстСообщения = НСтр("ru = 'Прямой обмен с банком не подключен.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Возврат;
		
	КонецЕсли;
	
	ЗагрузитьВыпискуПоПрямомуОбмену(СтруктураНастроек);

КонецПроцедуры

#Область Загрузка

&НаКлиенте
Процедура ЗагрузитьВыпискуПоПрямомуОбмену(СтруктураНастроек)
	
	// Счет определен, начинаем получение выписки.
	Если ЗначениеЗаполнено(СтруктураНастроек.БанковскийСчет) Тогда
		ПолучитьВыпискиПоПрямомуОбменуСБанком(СтруктураНастроек);
		
	// Счет не определен, спросим у пользователя по какому счету необходимо производить загрузку.
	// Может быть выбран счет по которому не подключен прямой обмен.
	// В этом случае производить загрузку не будем.
	Иначе
		ПараметрыФормы = Новый Структура;
		Отбор = Новый Структура();
		Отбор.Вставить("Владелец", 						СтруктураНастроек.Организация);
		Отбор.Вставить("ТипВладельцаСтрокой",   		"СправочникСсылка.Организации");
		Отбор.Вставить("ЕстьНастройкиОбменаСБанками", 	Истина);
		ПараметрыФормы.Вставить("Отбор", Отбор);
		ОписаниеОповещения = Новый ОписаниеОповещения("ВыборСчетаДляЗагрузкиВыпискиЗавершение", ЭтотОбъект, СтруктураНастроек);
		ОткрытьФорму("Справочник.БанковскиеСчета.ФормаВыбора", ПараметрыФормы, ЭтотОбъект,,,,ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборСчетаДляЗагрузкиВыпискиЗавершение(ВыбранныйБанковскийСчет, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныйБанковскийСчет = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Обновим отборы
	ОтборСчетОрганизации               = ВыбранныйБанковскийСчет;
	ОтборСчетОрганизацииИспользование  = Истина;
	УстановитьБыстрыйОтбор("СчетОрганизации");
	
	Если НЕ ОтборОрганизацияИспользование ИЛИ НЕ ЗначениеЗаполнено(ОтборОрганизация) Тогда
		ОтборОрганизация              = ПолучитьРеквизитСчета(ОтборСчетОрганизации, "Владелец");
		ОтборОрганизацияИспользование = Истина;
		УстановитьБыстрыйОтбор("Организация");
	КонецЕсли;
	
	// Загрузим выписку по выбранному счету
	ЗагрузитьВыписку(ОтборОрганизация, ОтборСчетОрганизации);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьВыпискиПоПрямомуОбменуСБанком(СтруктураНастроек)
	
	НастройкаОбменаСБанком = СтруктураНастроек.НастройкаОбменаСБанком;
	НомерСчета = ПолучитьРеквизитСчета(СтруктураНастроек.БанковскийСчет, "НомерСчета");
	
	// Необходимо определить период загрузки.
	СтруктураПериода = ПериодЗагрузкиВыписки(СтруктураНастроек);
	ПериодНачало     = СтруктураПериода.ДатаНачала;
	ПериодОкончание  = СтруктураПериода.ДатаОкончания;
	
	// Выписка будет обработана в событии "ОбработкаВыбора".
	ОбменСБанкамиКлиент.ПолучитьВыпискуБанка(
		НастройкаОбменаСБанком, ПериодНачало, ПериодОкончание, ЭтотОбъект, НомерСчета, Истина);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПериодЗагрузкиВыписки(Знач СтруктураНастроек)

	СтруктураПериода = Новый Структура;
	СтруктураПериода.Вставить("ДатаНачала");
	СтруктураПериода.Вставить("ДатаОкончания", ТекущаяДатаСеанса());
	
	// Если период рабочей даты меньше текущей даты сеанса, то используем рабочую дату
	ПериодРабочейДаты = ОбщегоНазначения.РабочаяДатаПользователя();
	Если ЗначениеЗаполнено(ПериодРабочейДаты) Тогда
		СтруктураПериода.ДатаОкончания = Мин(ПериодРабочейДаты, СтруктураПериода.ДатаОкончания);
	КонецЕсли;
	
	Организация    = СтруктураНастроек.Организация;
	БанковскийСчет = СтруктураНастроек.БанковскийСчет;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ОперацииПоБанковскомуСчету.Дата КАК Дата
	|ИЗ
	|	Документ._ДемоОперацииПоБанковскомуСчету КАК ОперацииПоБанковскомуСчету
	|ГДЕ
	|	ОперацииПоБанковскомуСчету.Организация = &Организация
	|	И ОперацииПоБанковскомуСчету.СчетОрганизации = &БанковскийСчет
	|	И ОперацииПоБанковскомуСчету.Проведен = ИСТИНА
	|	И ОперацииПоБанковскомуСчету.Дата < &Дата
	|УПОРЯДОЧИТЬ ПО
	|	Дата УБЫВ";
	
	Запрос.УстановитьПараметр("Организация",    Организация);
	Запрос.УстановитьПараметр("БанковскийСчет", БанковскийСчет);
	Запрос.УстановитьПараметр("Дата",           СтруктураПериода.ДатаОкончания);
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		СтруктураПериода.ДатаНачала = НачалоДня(Выборка.Дата);
	Иначе
		// Если дата неопределена, запросим данные за предыдущий квартал.
		СтруктураПериода.ДатаНачала = НачалоДня(ДобавитьМесяц(СтруктураПериода.ДатаОкончания, -3));
	КонецЕсли;
	
	Возврат СтруктураПериода;
	
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьНастройкуОбменаСБанком(Знач Организация, БанковскийСчет)

	Возврат Обработки._ДемоРазборБанковскойВыписки.ПолучитьНастройкуОбменаСБанком(Организация, БанковскийСчет);	
	
КонецФункции

&НаСервереБезКонтекста
Функция УстановитьБанковскийСчетОрганизации(БанковскийСчет, Знач Организация)
	
	Возврат Обработки._ДемоРазборБанковскойВыписки.УстановитьБанковскийСчетОрганизации(БанковскийСчет, Организация);
	
КонецФункции		

&НаСервереБезКонтекста
Функция ПолучитьДанныеВыпискиБанкаВФайл(Знач МассивВыписок)
	
	Возврат Обработки._ДемоРазборБанковскойВыписки.ПолучитьДанныеВыпискиБанкаВФайл(МассивВыписок);
	
КонецФункции	

#КонецОбласти

#Область ОбработкаЗагруженныхДанных

&НаКлиенте
Процедура ПрочитатьФайлВыпискиНаКлиенте(ОписаниеФайла, Кодировка = Неопределено)
	
	Результат = ЗагрузитьБанковскуюВыпискуНаСервере(ОписаниеФайла, Кодировка);
	Если Результат.Статус = "Выполняется" Тогда
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		АдресХранилища = Результат.АдресРезультата;
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		ФормаДлительнойОперации = ДлительныеОперацииКлиент.ОткрытьФормуДлительнойОперации(ЭтотОбъект, ИдентификаторЗадания);
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Результат.КраткоеПредставлениеОшибки);
	ИначеЕсли Результат.Статус = "Отменено" Тогда
		Возврат;
	Иначе // выполнено
		ОбработатьЗагрузкуБанковскойВыписки(Результат.РезультатЗагрузки);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗагрузитьБанковскуюВыпискуНаСервере(ОписаниеФайла, Кодировка)
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ФайлЗагрузки",                            ОписаниеФайла.Имя);
	СтруктураПараметров.Вставить("АдресХранилищаРаспознанныеДанныеИзБанка", ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор));
	СтруктураПараметров.Вставить("Кодировка",                               Кодировка);
	
	Если НЕ ПустаяСтрока(ОписаниеФайла.Хранение) Тогда
		СтруктураПараметров.Вставить("ДвоичныеДанные", ПолучитьИзВременногоХранилища(ОписаниеФайла.Хранение));
	КонецЕсли;
	
	СведенияОВладельцеБанковскогоСчетаИзКонтекста = Новый Структура;
	СведенияОВладельцеБанковскогоСчетаИзКонтекста.Вставить("Организация");
	СведенияОВладельцеБанковскогоСчетаИзКонтекста.Вставить("БанковскийСчетОрганизации");
	Если ЗначениеЗаполнено(ОтборОрганизация) Тогда
		СведенияОВладельцеБанковскогоСчетаИзКонтекста.Вставить("Организация", ОтборОрганизация);
	КонецЕсли;
	Если ЗначениеЗаполнено(ОтборСчетОрганизации) Тогда
		СведенияОВладельцеБанковскогоСчетаИзКонтекста.Вставить("БанковскийСчетОрганизации", ОтборСчетОрганизации);
	КонецЕсли;
	СтруктураПараметров.Вставить("СведенияОВладельцеБанковскогоСчетаИзКонтекста", СведенияОВладельцеБанковскогоСчетаИзКонтекста);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Загрузка выписки из банка'");
	Результат = ДлительныеОперации.ВыполнитьВФоне("Обработки._ДемоРазборБанковскойВыписки.ФоноваяЗагрузкаБанковскойВыпискиИзЖурнала",
		СтруктураПараметров, ПараметрыВыполнения);
	
	Если Результат.Статус = "Выполнено" Тогда
		АдресХранилища = Результат.АдресРезультата;
		Результат.Вставить("РезультатЗагрузки", ПолучитьИзВременногоХранилища(АдресХранилища));
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ОбработатьЗагрузкуБанковскойВыписки(РезультатЗагрузки)
	
	Для Каждого СообщениеПользователю Из РезультатЗагрузки.СообщенияПользователю Цикл
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СообщениеПользователю.Текст);
	КонецЦикла;
	
	Если РезультатЗагрузки.РезультатВыполнения = "ЕстьОшибкиЧтенияФайла" Тогда
		
		ПоказатьПредупреждение(, НСтр("ru = 'Не удалось прочитать файл'"));
		
	ИначеЕсли РезультатЗагрузки.РезультатВыполнения = "ЕстьОшибкиРаспознавания" 
		ИЛИ РезультатЗагрузки.РезультатВыполнения = "ЕстьОшибкиСозданияКонтрагентов"
		ИЛИ РезультатЗагрузки.РезультатВыполнения = "ЕстьОшибкиСозданияДокументов"
		ИЛИ РезультатЗагрузки.РезультатВыполнения = "НеобходимоСоздатьКонтрагентов" Тогда
		
		Если РезультатЗагрузки.Свойство("Организация") Тогда
			ОтборОрганизация = РезультатЗагрузки.Организация;
			ОтборОрганизацияИспользование = ЗначениеЗаполнено(РезультатЗагрузки.Организация);
			УстановитьБыстрыйОтбор("Организация");
		КонецЕсли;
		
		Если РезультатЗагрузки.Свойство("БанковскийСчет") Тогда
			ОтборСчетОрганизации = РезультатЗагрузки.БанковскийСчет;
			ОтборСчетОрганизацииИспользование = ЗначениеЗаполнено(РезультатЗагрузки.БанковскийСчет);
			УстановитьБыстрыйОтбор("ОтборСчетОрганизации");
		КонецЕсли;
		
		ПараметрыФормыКлиентБанка = Новый Структура;
		ПараметрыФормыКлиентБанка.Вставить("АдресХранилищаРаспознанныеДанныеИзБанка", РезультатЗагрузки.АдресХранилищаРаспознанныеДанныеИзБанка);
		ПараметрыФормыКлиентБанка.Вставить("СообщенияПользователюВФормеОбменСБанком", РезультатЗагрузки.СообщенияПользователюВФормеОбменСБанком);
		ПараметрыФормыКлиентБанка.Вставить("НачалоПериода",                           ПериодНачало);
		ПараметрыФормыКлиентБанка.Вставить("КонецПериода",                            ПериодОкончание);
		ПараметрыФормыКлиентБанка.Вставить("НастройкаОбменаСБанком",                  НастройкаОбменаСБанком);
		ПараметрыФормыКлиентБанка.Вставить("ЭлектроннаяВыпискаБанка",                 ВыпискиБанка);
		
		Если РезультатЗагрузки.Свойство("ИмяФайла") Тогда 
			ПараметрыФормыКлиентБанка.Вставить("ФайлСсылка", РезультатЗагрузки.ИмяФайла);
		КонецЕсли;
		
		ОткрытьФормуЗагрузкиИРазбораВыписки(ПараметрыФормыКлиентБанка);
		
	ИначеЕсли РезультатЗагрузки.РезультатВыполнения = "УспешнаяЗагрузка" Тогда
		
		Если РезультатЗагрузки.Свойство("Организация") Тогда
			ОтборОрганизация = РезультатЗагрузки.Организация;
			ОтборОрганизацияИспользование = ЗначениеЗаполнено(РезультатЗагрузки.Организация);
			УстановитьБыстрыйОтбор("Организация");
		КонецЕсли;
		
		Если РезультатЗагрузки.Свойство("БанковскийСчет") Тогда
			ОтборБанковскийСчет = РезультатЗагрузки.БанковскийСчет;
			ОтборБанковскийСчетИспользование = ЗначениеЗаполнено(РезультатЗагрузки.БанковскийСчет);
			УстановитьБыстрыйОтбор("БанковскийСчет");
		КонецЕсли;
		
		Элементы.Список.Обновить();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ФоновоеЗадание

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	Попытка
		Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда
			ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
			РезультатЗагрузки = ПолучитьИзВременногоХранилища(АдресХранилища);
			ОбработатьЗагрузкуБанковскойВыписки(РезультатЗагрузки);
		Иначе
			ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
			ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", ПараметрыОбработчикаОжидания.ТекущийИнтервал, Истина);
			ОценкаВремени = "";
		КонецЕсли;
	Исключение
		ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

#КонецОбласти

#Область УправлениеФормой

&НаСервере
Процедура ОтборБанковскийСчетПриИзмененииСервер()
	
	
	УстановитьВосстановленныеОтборы();
	
КонецПроцедуры

&НаСервере
Процедура ОтборОрганизацияПриИзмененииСервер()

	УстановитьБанковскийСчетОрганизации(ОтборСчетОрганизации, ОтборОрганизация);
	ОтборОрганизацияИспользование    = ЗначениеЗаполнено(ОтборОрганизация);
	ОтборСчетОрганизацииИспользование = ЗначениеЗаполнено(ОтборСчетОрганизации);
	
	УстановитьВосстановленныеОтборы();

КонецПроцедуры

&НаСервере
Процедура УстановитьВосстановленныеОтборы()
	
	УстановитьБыстрыйОтбор("Организация");
	УстановитьБыстрыйОтбор("СчетОрганизации");
	
КонецПроцедуры


#КонецОбласти

#Область ПрочиеПроцедуры

&НаСервере
Процедура УстановитьБыстрыйОтбор(ИмяПоля, ВидСравнения = Неопределено)
	
	ПравоеЗначение = ЭтотОбъект["Отбор" + ИмяПоля];
	Использование  = ЭтотОбъект["Отбор" + ИмяПоля + "Использование"];
	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(
		ЭтотОбъект.Список.КомпоновщикНастроек.Настройки.Отбор, 
		ИмяПоля);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(
		ЭтотОбъект.Список.КомпоновщикНастроек.Настройки.Отбор,
		ИмяПоля,
		ПравоеЗначение,
		ВидСравнения,
		,
		Использование);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьРеквизитСчета(Знач БанковскийСчет, Знач ИмяРеквизита)
	
	Если ЗначениеЗаполнено(БанковскийСчет) Тогда
		Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(БанковскийСчет, ИмяРеквизита);
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

#КонецОбласти

&НаКлиенте
Процедура ОткрытьФормуЗагрузкиИРазбораВыписки(ПараметрыФормы = Неопределено)
	
	Если ПараметрыФормы = Неопределено Тогда 
		ПараметрыФормы = Новый Структура;
	КонецЕсли;	
	
	Если ОтборОрганизацияИспользование И ЗначениеЗаполнено(ОтборОрганизация) Тогда
		ПараметрыФормы.Вставить("Организация",    ОтборОрганизация);
	КонецЕсли;
	
	Если ОтборСчетОрганизацииИспользование И ЗначениеЗаполнено(ОтборСчетОрганизации) Тогда
		ПараметрыФормы.Вставить("МассивСчетов", ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ОтборСчетОрганизации));
	КонецЕсли;
	
	ОткрытьФорму("Обработка._ДемоРазборБанковскойВыписки.Форма.Форма", ПараметрыФормы, ЭтотОбъект);

КонецПроцедуры

&НаСервереБезКонтекста
Функция НастройкиОбмена()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	НастройкиОбменСБанками.Ссылка
	|ИЗ
	|	Справочник.НастройкиОбменСБанками КАК НастройкиОбменСБанками
	|ГДЕ
	|	НЕ НастройкиОбменСБанками.Недействительна
	|	И НЕ НастройкиОбменСБанками.ПометкаУдаления";
	
	Возврат Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции


#КонецОбласти