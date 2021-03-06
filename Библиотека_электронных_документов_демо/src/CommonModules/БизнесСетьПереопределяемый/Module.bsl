////////////////////////////////////////////////////////////////////////////////
// Подсистема "Бизнес-сеть".
// ОбщийМодуль.БизнесСетьПереопределяемый.
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Создание контрагента в информационной базе по реквизитам.
//
// Параметры:
//   РеквизитыКонтрагента - Структура - реквизиты необходимые для создания контрагента.
//    * ИНН - Строка - ИНН контрагента.
//    * КПП - Строка - КПП контрагента.
//    * Наименование - Строка - наименование контрагента.
//   Контрагент - СправочникСсылка - ссылка на созданного контрагента.
//   Отказ - Булево - признак ошибки.
//
Процедура СоздатьКонтрагентаПоРеквизитам(Знач РеквизитыКонтрагента, Контрагент, Отказ = Ложь) Экспорт
	
	// _Демо начало примера
	
	РеквизитыКонтрагента.Вставить("ЭтоЭлектронныйДокумент", Истина);
	РеквизитыКонтрагента.Вставить("НаименованиеПолное", РеквизитыКонтрагента.Наименование);
	
	Попытка
		
		Объект = Справочники.Контрагенты.СоздатьЭлемент();
		Объект.Заполнить(РеквизитыКонтрагента);
		
		Если СтрДлина(РеквизитыКонтрагента.ИНН) = 10 Тогда
			Объект.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо;
		ИначеЕсли СтрДлина(РеквизитыКонтрагента.ИНН) = 12 Тогда
			Объект.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель;
		КонецЕсли;
	
		Объект.Записать();
		Контрагент = Объект.Ссылка;
	Исключение
		ТекстСообщения = НСтр("ru = 'Ошибка при записи нового элемента справочника Контрагенты.'")
			+ Символы.ПС + НСтр("ru ='Подробности см. в журнале регистрации.'",
			ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,, Отказ);
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Создание контрагента'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка, Метаданные.Справочники.Контрагенты,,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
	// _Демо конец примера
	
КонецПроцедуры

// Возвращает контакты пользователя для регистрации в сервисе.
//
// Параметры:
//   КонтактноеЛицо - СправочникСсылка - пользователь программы, контактное лицо.
//   Результат - Структура - информация о пользователе, см. БизнесСеть.ОписаниеКонтактнойИнформацииПользователя():
//     * ФИО - Строка - ФИО пользователя.
//     * Телефон - Строка - номер телефона.
//     * ЭлектроннаяПочта - Строка - адрес электронной почты пользователя.
//
Процедура ПолучитьКонтактнуюИнформациюПользователя(Знач КонтактноеЛицо, Результат) Экспорт
	
	// _Демо начало примера
	
	Если КонтактноеЛицо = Пользователи.СсылкаНеуказанногоПользователя() Тогда 
		ФИО = НСтр("ru = 'Иванов Иван Иванович'");
	Иначе
		ФИО = Строка(КонтактноеЛицо)
	КонецЕсли;
	
	Результат.ФИО = ФИО;
	Результат.ЭлектроннаяПочта = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(КонтактноеЛицо, Справочники.ВидыКонтактнойИнформации.EmailПользователя);
	Результат.Телефон = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(КонтактноеЛицо, Справочники.ВидыКонтактнойИнформации.ТелефонПользователя);
	
	// _Демо конец примера
	
КонецПроцедуры

// Проверка соответствия реквизитов в документах.
//
// Параметры:
//   ДокументыКонтроля - Массив - проверяемые ссылки объектов.
//   ТекстСообщения - Строка - текст сообщения в случае ошибки проверки.
//   Отказ - Булево - результат проверки.
//
Процедура ВыполнитьКонтрольРеквизитовДокументов(Знач ДокументыКонтроля, ТекстСообщения, Отказ) Экспорт
	
	// _Демо начало примера
	
	ИмяМетаданных = "";
	Для каждого Ссылка Из ДокументыКонтроля Цикл
		Если ИмяМетаданных = "" Тогда
			ИмяМетаданных = Ссылка.Метаданные().Имя;
		ИначеЕсли ИмяМетаданных <> Ссылка.Метаданные().Имя Тогда
			Отказ = Истина;
			ТекстСообщения = НСтр("ru = 'Операция невозможна для разных видов документов'");
			Возврат;
		КонецЕсли;
	КонецЦикла;
	
	Если ИмяМетаданных = "РеализацияТоваровУслуг" Тогда
		Реквизиты = "Организация, Контрагент";
	Иначе
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = "ВЫБРАТЬ РАЗЛИЧНЫЕ";
	МассивРеквизитов = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивСлов(Реквизиты, ",");
	ПоследнийЭлемент = МассивРеквизитов.Получить(МассивРеквизитов.Количество()-1);
	Для каждого ЗначениеМассива Из МассивРеквизитов Цикл
		ТекстЗапроса = ТекстЗапроса + Символы.ПС + Символы.Таб + ИмяМетаданных + "." + СокрЛП(ЗначениеМассива)
			+ ?(ЗначениеМассива = ПоследнийЭлемент, "", ",");
	КонецЦикла;
	ТекстЗапроса = ТекстЗапроса + Символы.ПС + "ИЗ " + "Документ." + ИмяМетаданных + " КАК "
		+ ИмяМетаданных	+ " ГДЕ " + ИмяМетаданных + ".Ссылка В(&ДокументыКонтроля)";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("ДокументыКонтроля", ДокументыКонтроля);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Количество() > 1 Тогда
		Отказ = Истина;
		Шаблон = НСтр("ru = 'Операция невозможна. Отличаются реквизиты документов (%1)'");
		ТекстСообщения = СтрШаблон(Шаблон, Реквизиты);
	КонецЕсли;
	
	// _Демо конец примера
	
КонецПроцедуры

// Получение списка контрагентов по сделкам для отправки приглашений.
//
// Параметры:
//  Организация			 - СправочникСсылка - ссылка на организацию, от которой производится приглашение.
//  РежимЗаполнения		 - Строка - режим заполнения контрагентов: "ЗаполнитьПоПоставкам", "ЗаполнитьПоЗакупкам", "ЗаполнитьПоВсемСделкам".
//  НачалоПериода		 - Дата - начало периода заполнения.
//  СписокКонтрагентов	 - ТаблицаЗначений - список контрагентов:
//    * Ссылка - СправочникСсылка - контрагент.
//    * ЭлектроннаяПочта - Строка - адрес электронной почты.
//
Процедура ПолучитьКонтрагентовПоСделкам(Знач Организация, Знач РежимЗаполнения, Знач НачалоПериода, СписокКонтрагентов) Экспорт
	
	// _Демо начало примера
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ЗаполнитьПоПоставкам",   РежимЗаполнения = "ЗаполнитьПоПоставкам");
	Запрос.УстановитьПараметр("ЗаполнитьПоЗакупкам",    РежимЗаполнения = "ЗаполнитьПоЗакупкам");
	Запрос.УстановитьПараметр("ЗаполнитьПоВсемСделкам", РежимЗаполнения = "ЗаполнитьПоВсемСделкам");
	Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
	Запрос.УстановитьПараметр("Организация",   Организация);
	
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Контрагенты.Ссылка КАК Ссылка
	|ИЗ
	|	(ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		ДокументыПродажи.Контрагент КАК Ссылка
	|	ИЗ
	|		Документ.РеализацияТоваровУслуг КАК ДокументыПродажи
	|	ГДЕ
	|		ДокументыПродажи.Дата >= &НачалоПериода
	|		И НЕ ДокументыПродажи.ПометкаУдаления
	|		И (&ЗаполнитьПоПоставкам
	|				ИЛИ &ЗаполнитьПоВсемСделкам)
	|		И ДокументыПродажи.Организация = &Организация
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		ДокументыЗакупки.Контрагент
	|	ИЗ
	|		Документ.ПоступлениеТоваровУслуг КАК ДокументыЗакупки
	|	ГДЕ
	|		ДокументыЗакупки.Дата >= &НачалоПериода
	|		И НЕ ДокументыЗакупки.ПометкаУдаления
	|		И (&ЗаполнитьПоЗакупкам
	|				ИЛИ &ЗаполнитьПоВсемСделкам)
	|		И ДокументыЗакупки.Организация = &Организация) КАК Контрагенты
	|
	|УПОРЯДОЧИТЬ ПО
	|	Контрагенты.Ссылка";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		НоваяСтрока = СписокКонтрагентов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
		ОбменСКонтрагентамиПереопределяемый.АдресЭлектроннойПочтыКонтрагента(
			Выборка.Ссылка, НоваяСтрока.ЭлектроннаяПочта);
	КонецЦикла;
	
	// _Демо конец примера
	
КонецПроцедуры

#КонецОбласти