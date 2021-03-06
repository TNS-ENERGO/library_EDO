////////////////////////////////////////////////////////////////////////////////
// _ДемоИнтеграцияСЯндексКассой: использование подсистемы интеграции с Яндекс.Кассой.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Начинает фоновое выполнение загрузки операций по Яндекс.Кассе.
//
// Параметры:
//  ПараметрыЗагрузки - Структура - параметры загрузки операций.
//   * Период - СтандартныйПериод, Структура - Период за который будут выбираться операции по Яндекс.Кассе.
//    ** ДатаНачала - Дата - начало периода запроса. 
//                           Если не указан, дата начала будет определена автоматически.
//    ** ДатаОкончания - Дата - окончание периода запроса. 
//                              Если не указан, дата окончания будет равна текущей дате.
//   * Организация - ОпределяемыйТип.Организация - организация, по которой нужно отобрать операции. 
//                                                 Если не указана то, будут обработаны все действительные настройки;
//   * СДоговором - Булево, Неопределено - позволяет указать для каких настроек следует загружать операции:
//    ** Неопределено - будут загружены и операции по схемам "С договором" и "Без договора"
//    ** Истина - будут загружены операции по схеме "С договором"
//    ** Ложь - будут загружены операции по схеме "Без договора"
//    Если указан параметр Организация, этот параметр не учитывается.
//
// Возвращаемое значение:
//  Структура - описание длительной операции. См. ДлительныеОперации.ВыполнитьВФоне.
//
Функция НачатьЗагрузкуОперацийПоЯндексКассе(Знач ПараметрыЗагрузки) Экспорт
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(Новый УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Загрузка операций по Яндекс.Кассе'");
	
	ИмяПроцедуры = "_ДемоИнтеграцияСЯндексКассой.ЗагрузитьОперацииПоЯндексКассеВФоне";
	
	ДлительнаяОперация = ДлительныеОперации.ВыполнитьВФоне(ИмяПроцедуры, ПараметрыЗагрузки, ПараметрыВыполнения);
	
	Возврат ДлительнаяОперация;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// См. ИнтеграцияСЯндексКассойПереопределяемый.ПриОпределенииОснованийПлатежа.
Процедура ПриОпределенииОснованийПлатежа(ОснованияПлатежа) Экспорт
	
	ОснованияПлатежа.Добавить("Документ._ДемоЗаказПокупателя");
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ЗаполнитьРеквизитыОрганизации.
Процедура ЗаполнитьРеквизитыОрганизации(Знач Организация, Реквизиты) Экспорт
	
	РеквизитыСтрока = "ИНН, КПП, ЮрФизЛицо";
	РеквизитыОрганизации = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Организация, РеквизитыСтрока);
	Реквизиты.ИНН = РеквизитыОрганизации.ИНН;
	Реквизиты.КПП = РеквизитыОрганизации.КПП;
	Реквизиты.Резидент = Не (РеквизитыОрганизации.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицоНеРезидент);
	Реквизиты.ЭтоЮрЛицо = (РеквизитыОрганизации.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ЮрЛицо);
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ЗаполнитьДанныеОснованияПлатежа.
Процедура ЗаполнитьДанныеОснованияПлатежа(Знач ОснованиеПлатежа, ДанныеОснованияПлатежа) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Счет.Номер КАК Номер,
	|	Счет.Дата КАК Дата,
	|	Счет.Валюта.Код КАК Валюта,
	|	Счет.СуммаДокумента КАК Сумма,
	|	Счет.БанковскийСчет.Банк.Код КАК БанковскийСчетБанкБИК,
	|	Счет.БанковскийСчет.Банк.Наименование КАК БанковскийСчетБанкНаименование,
	|	Счет.БанковскийСчет.Банк.КоррСчет КАК БанковскийСчетБанкКоррСчет,
	|	Счет.БанковскийСчет.НомерСчета КАК БанковскийСчетНомерСчета,
	|	Счет.Организация КАК Организация,
	|	Счет.Организация.ИНН КАК ОрганизацияИНН,
	|	Счет.Организация.КПП КАК ОрганизацияКПП,
	|	Счет.Организация.Наименование КАК ОрганизацияНаименование,
	|	Счет.Контрагент КАК Контрагент,
	|	Счет.Контрагент.НаименованиеПолное КАК КонтрагентНаименованиеПолное
	|ИЗ
	|	Документ._ДемоЗаказПокупателя КАК Счет
	|ГДЕ
	|	Счет.Ссылка = &Счет
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СчетНоменклатура.НомерСтроки КАК НомерСтроки,
	|	СчетНоменклатура.Номенклатура.Наименование КАК Наименование,
	|	СчетНоменклатура.Номенклатура.НаименованиеПолное КАК НаименованиеПолное,
	|	ПРЕДСТАВЛЕНИЕ(СчетНоменклатура.Характеристика) КАК Характеристика,
	|	СчетНоменклатура.Количество КАК Количество,
	|	СчетНоменклатура.Цена КАК Цена,
	|	""18%"" КАК СтавкаНДС,
	|	4 КАК СтавкаНДСКод,
	|	ПРЕДСТАВЛЕНИЕ(СчетНоменклатура.Ссылка.Валюта) КАК Валюта,
	|	СчетНоменклатура.Номенклатура.Артикул КАК Артикул,
	|	ПРЕДСТАВЛЕНИЕ(СчетНоменклатура.ЕдиницаИзмерения) КАК ЕдиницаИзмерения,
	|	ПРЕДСТАВЛЕНИЕ(СчетНоменклатура.Номенклатура.ВидНоменклатуры) КАК ВидНоменклатуры,
	|	ПРЕДСТАВЛЕНИЕ(СчетНоменклатура.Номенклатура.Родитель) КАК Родитель,
	|	СчетНоменклатура.Сумма КАК Сумма
	|ИЗ
	|	Документ._ДемоЗаказПокупателя.Товары КАК СчетНоменклатура
	|ГДЕ
	|	СчетНоменклатура.Ссылка = &Счет";
	Запрос.УстановитьПараметр("Счет", ОснованиеПлатежа);
	
	Результаты = Запрос.ВыполнитьПакет();
	
	// шапка счета
	Если Не Результаты[0].Пустой() Тогда
		
		Выборка = Результаты[0].Выбрать();
		Выборка.Следующий();
		
		ДанныеОснованияПлатежа.Идентификатор = "ЗП" + ОснованиеПлатежа.УникальныйИдентификатор();
		ДанныеОснованияПлатежа.Номер = Выборка.Номер;
		ДанныеОснованияПлатежа.Сумма = Выборка.Сумма;
		ДанныеОснованияПлатежа.Валюта = Выборка.Валюта;
		ДанныеОснованияПлатежа.НазначениеПлатежа = СтрШаблон(НСтр("ru = 'Оплата по счету №%1 от %2'"),
			Выборка.Номер, Формат(Выборка.Дата,"ДЛФ=D"));
		ДанныеОснованияПлатежа.БанковскийСчет.БанкБИК = Выборка.БанковскийСчетБанкБИК;
		ДанныеОснованияПлатежа.БанковскийСчет.БанкНаименование = Выборка.БанковскийСчетБанкНаименование;
		ДанныеОснованияПлатежа.БанковскийСчет.БанкКоррСчет = Выборка.БанковскийСчетБанкКоррСчет;
		ДанныеОснованияПлатежа.БанковскийСчет.НомерСчета = Выборка.БанковскийСчетНомерСчета;
		ДанныеОснованияПлатежа.Продавец.УчетнаяПолитика = 1; // ОСН
		ДанныеОснованияПлатежа.Продавец.ИНН = Выборка.ОрганизацияИНН;
		ДанныеОснованияПлатежа.Продавец.КПП = Выборка.ОрганизацияКПП;
		ДанныеОснованияПлатежа.Продавец.Наименование = Выборка.ОрганизацияНаименование;
		ДанныеОснованияПлатежа.Продавец.Телефон = "";
		ДанныеОснованияПлатежа.Продавец.ЭлектроннаяПочта = "";
		ДанныеОснованияПлатежа.Продавец.ФактическийАдрес = "";
		ДанныеОснованияПлатежа.Продавец.ЮридическийАдрес = "";
		ДанныеОснованияПлатежа.Покупатель.Идентификатор = Выборка.Контрагент.УникальныйИдентификатор();
		ДанныеОснованияПлатежа.Покупатель.Наименование = Выборка.КонтрагентНаименованиеПолное;
		ДанныеОснованияПлатежа.Покупатель.КонтактныеДанныеЧека = "";
		
	КонецЕсли;
	
	// Номенклатура
	Если Не Результаты[1].Пустой() Тогда
		
		Выборка = Результаты[1].Выбрать();
		Пока Выборка.Следующий() Цикл
			
			СтрокаНоменклатуры = ДанныеОснованияПлатежа.Номенклатура.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаНоменклатуры, Выборка);
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ПриОпределенииДополнительныхНастроекЯндексКассы.
Процедура ПриОпределенииДополнительныхНастроекЯндексКассы(ДополнительныеНастройки) Экспорт
	
	СтрокаНастройки = ДополнительныеНастройки.Добавить();
	СтрокаНастройки.Настройка = "БанковскийСчет";
	СтрокаНастройки.Представление = НСтр("ru = 'Банковский счет'");
	СтрокаНастройки.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.БанковскиеСчета");
	
	СтрокаНастройки = ДополнительныеНастройки.Добавить();
	СтрокаНастройки.Настройка = "Эквайер";
	СтрокаНастройки.Представление = НСтр("ru = 'Эквайер'");
	СтрокаНастройки.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.Контрагенты");
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ПередНачаломРедактированияДополнительныхНастроекЯндексКассы.
Процедура ПередНачаломРедактированияДополнительныхНастроекЯндексКассы(Контекст, Отказ = Ложь) Экспорт
	
	Если Не Контекст.СДоговором Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если Не Контекст.НоваяНастройка Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	БанковскиеСчета.Ссылка КАК БанковскийСчет
	|ИЗ
	|	Справочник.БанковскиеСчета КАК БанковскиеСчета
	|ГДЕ
	|	БанковскиеСчета.Владелец = &Организация
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка";
	Запрос.УстановитьПараметр("Организация", Контекст.Организация);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		
		Контекст.Форма[Контекст.Префикс + "БанковскийСчет"] = Выборка.БанковскийСчет;
		
	КонецЕсли;
	
	Эквайер = ИнтеграцияСЯндексКассой.ДанныеЭквайераЯндексКасса(ТекущаяДатаСеанса());
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Контрагенты.Ссылка КАК Эквайер
	|ИЗ
	|	Справочник.Контрагенты КАК Контрагенты
	|ГДЕ
	|	Контрагенты.ИНН = &ИНН
	|	И Контрагенты.КПП = &КПП";
	Запрос.УстановитьПараметр("ИНН", Эквайер.ИНН);
	Запрос.УстановитьПараметр("КПП", Эквайер.КПП);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		
		Контекст.Форма[Контекст.Префикс + "Эквайер"] = Выборка.Эквайер;
		
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ПередОкончаниемРедактированияДополнительныхНастроекЯндексКассы.
Процедура ПередОкончаниемРедактированияДополнительныхНастроекЯндексКассы(Контекст, Отказ = Ложь) Экспорт
	
	Если Не Контекст.СДоговором Тогда
		Возврат;
	КонецЕсли;
	
	ИмяРеквизита = Контекст.Префикс + "БанковскийСчет";
	Если Не ЗначениеЗаполнено(Контекст.Форма[ИмяРеквизита]) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не заполнен банковский счет'"),, ИмяРеквизита);
		Отказ = Истина;
	КонецЕсли;
	
	ИмяРеквизита = Контекст.Префикс + "Эквайер";
	Если Не ЗначениеЗаполнено(Контекст.Форма[ИмяРеквизита]) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не заполнен эквайер'"),, ИмяРеквизита);
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ПриСозданииФормыНастроекЯндексКассы.
Процедура ПриСозданииФормыНастроекЯндексКассы(Форма, Группа, Префикс, ДополнительныеНастройки) Экспорт
	
	// Реквизиты
	
	ДобавляемыеРеквизиты = Новый Массив;
	
	Реквизит = Новый РеквизитФормы(
		Префикс + "БанковскийСчет",
		Новый ОписаниеТипов("СправочникСсылка.БанковскиеСчета"),
		,
		НСтр("ru = 'Банковский счет'"),
		Истина);
	ДобавляемыеРеквизиты.Добавить(Реквизит);
	ДополнительныеНастройки.Вставить("БанковскийСчет", Реквизит.Имя);
		
	Реквизит = Новый РеквизитФормы(
		Префикс + "Эквайер",
		Новый ОписаниеТипов("СправочникСсылка.Контрагенты"),
		,
		НСтр("ru = 'Эквайер'"),
		Истина);
	ДобавляемыеРеквизиты.Добавить(Реквизит);
	ДополнительныеНастройки.Вставить("Эквайер", Реквизит.Имя);
	
	Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	// Элементы
	ТипПолеФормы = Тип("ПолеФормы");
	Элементы = Форма.Элементы;
	
	ГруппаНастройкиУчета = Элементы.Добавить(Префикс + "ГруппаНастройкиУчета", Тип("ГруппаФормы"), Группа);
	ГруппаНастройкиУчета.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаНастройкиУчета.Заголовок = НСтр("ru = 'Укажите настройки учета'");
	ГруппаНастройкиУчета.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	ГруппаНастройкиУчета.ОтображатьЗаголовок = Истина;
	ГруппаНастройкиУчета.Отображение = ОтображениеОбычнойГруппы.ОбычноеВыделение;
	
	ИмяРеквизита = Префикс + "БанковскийСчет";
	Поле = Элементы.Добавить(ИмяРеквизита, ТипПолеФормы, ГруппаНастройкиУчета);
	Поле.ПутьКДанным = ИмяРеквизита;
	Поле.Вид = ВидПоляФормы.ПолеВвода;
	Поле.Подсказка = НСтр("ru = 'Банковский счет, указанный в договоре, на который будут перечисляться денежные средства'");
	Поле.ОтображениеПодсказки = ОтображениеПодсказки.ОтображатьСправа;
	Поле.АвтоОтметкаНезаполненного = Истина;
	
	Связь = Новый СвязьПараметраВыбора("Отбор.Владелец", "Организация");
	ВсеСвязи = Новый Массив();
	ВсеСвязи.Добавить(Связь);
	ВсеСвязиФикс = Новый ФиксированныйМассив(ВсеСвязи);
	Поле.СвязиПараметровВыбора = ВсеСвязиФикс; 
	
	ИмяРеквизита = Префикс + "Эквайер";
	Поле = Элементы.Добавить(ИмяРеквизита, ТипПолеФормы, ГруппаНастройкиУчета);
	Поле.Вид = ВидПоляФормы.ПолеВвода;
	Поле.ПутьКДанным = ИмяРеквизита;
	Поле.Подсказка = НСтр("ru = 'Организация-партнер, с которой заключен договор эквайринга.'");
	Поле.ОтображениеПодсказки = ОтображениеПодсказки.Кнопка;
	Поле.АвтоОтметкаНезаполненного = Истина;
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ПриПроверкеЗаполненияОснованияПлатежа.
Процедура ПриПроверкеЗаполненияОснованияПлатежа(Знач ОснованиеПлатежа, Отказ) Экспорт
	
	Если ТипЗнч(ОснованиеПлатежа) = Тип("ДокументСсылка._ДемоЗаказПокупателя") Тогда
		
		Реквизиты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ОснованиеПлатежа, "БанковскийСчет,СуммаДокумента,Валюта");
		Если Не ЗначениеЗаполнено(Реквизиты.БанковскийСчет) Тогда
			Отказ = Истина;
			ТекстСообщения = НСтр("ru = 'Не заполнен банковский счет'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ОснованиеПлатежа, "БанковскийСчет");
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Реквизиты.СуммаДокумента) Тогда
			Отказ = Истина;
			ТекстСообщения = НСтр("ru = 'Не заполнены товары или их стоимость'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ОснованиеПлатежа, "Товары");
		КонецЕсли;
		
		ВалютаРуб = Справочники.Валюты.НайтиПоКоду("643");
		
		Если Реквизиты.Валюта <> ВалютаРуб Тогда
			Отказ = Истина;
			ТекстСообщения = СтрШаблон(НСтр("ru = 'Выставлять счета можно только в валюте: %1'"), ВалютаРуб);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ОснованиеПлатежа, "Валюта");
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ПриЗагрузкеОперацийПоЯндексКассе.
Процедура ПриЗагрузкеОперацийПоЯндексКассе(Знач Операции, Результат, Отказ) Экспорт
	
	Результат = 0;
	
	Если НЕ Операции.СДоговором Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОперацииКЗагрузке = НеучтенныеОперации(Операции.ОперацииМассивСтруктур);
	
	Для каждого Операция Из ОперацииКЗагрузке Цикл
				
		Если Операция.ВидОперации = "Оплата" Тогда
			
			ДокументОплаты = Документы._ДемоОперацияПоЯндексКассе.СоздатьДокумент();
			ДокументОплаты.Дата = Операция.ДатаОплаты;
			ДокументОплаты.ХозяйственнаяОперация = "Оплата";
			ДокументОплаты.Организация = Операции.Организация;
			ДокументОплаты.БанковскийСчет = Операция.БанковскийСчет;
			ДокументОплаты.Эквайер = Операция.Эквайер;
			ДокументОплаты.ИдентификаторТранзакции = Операция.ИдентификаторТранзакции;
			ДокументОплаты.ИдентификаторПлатежа = Операция.ИдентификаторПлатежа;
			ДокументОплаты.СуммаДокумента = Операция.СуммаДокумента;
			ДокументОплаты.СуммаКомиссии = Операция.СуммаДокумента - Операция.СуммаКЗачислениюНаСчетОрганизации;
			ДокументОплаты.Валюта = Операция.ВалютаДокумента;
			ДокументОплаты.СпособОплаты = Операция.СпособОплаты;
			ДокументОплаты.НазначениеПлатежа = Операция.НазначениеПлатежа;
			
			Счет = СчетПоИдентификаторуПлатежа(Операция.ИдентификаторПлатежа);
			
			Если ЗначениеЗаполнено(Счет) Тогда
				ДокументОплаты.ОснованиеПлатежа = Счет;
				ДокументОплаты.Контрагент = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Счет, "Контрагент");
			КонецЕсли;
			
			ДокументОплаты.Записать(РежимЗаписиДокумента.Проведение);
			
		ИначеЕсли Операция.ВидОперации = "Возврат" Тогда
			
			ДокументВозврата = Документы._ДемоОперацияПоЯндексКассе.СоздатьДокумент();
			ДокументВозврата.Дата = Операция.ДатаИсполненияЗапросаНаВозврат;
			ДокументВозврата.ХозяйственнаяОперация = "Возврат";
			ДокументВозврата.Организация = Операции.Организация;
			ДокументВозврата.БанковскийСчет = Операция.БанковскийСчет;
			ДокументВозврата.Эквайер = Операция.Эквайер;
			ДокументВозврата.ИдентификаторТранзакции = Операция.ИдентификаторТранзакции;
			ДокументВозврата.ИдентификаторПлатежа = Операция.ИдентификаторПлатежа;
			ДокументВозврата.ИдентификаторВозврата = Операция.ИдентификаторВозврата;
			ДокументВозврата.СуммаДокумента = Операция.СуммаДокумента;
			ДокументВозврата.Валюта = Операция.ВалютаДокумента;
			ДокументВозврата.ТипОперацииВозврата = Перечисления._ДемоТипыОперацийВозвратаЧерезЯндексКассу.Возврат;
			
			Оплата = ОплатаПоИдентификаторуПлатежа(Операция.ИдентификаторПлатежа);
			
			Если ЗначениеЗаполнено(Оплата) Тогда
				
				РеквизитыОплаты = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Оплата, "Дата, Контрагент, СуммаДокумента, СуммаКомиссии");
				ДокументВозврата.ОснованиеПлатежа = Оплата;
				ДокументВозврата.Контрагент = РеквизитыОплаты.Контрагент;
				Если НачалоДня(РеквизитыОплаты.Дата) = НачалоДня(ДокументВозврата.Дата) Тогда
					ДокументВозврата.ТипОперацииВозврата = Перечисления._ДемоТипыОперацийВозвратаЧерезЯндексКассу.Отмена;
					ПроцентКомиссии = 100 * РеквизитыОплаты.СуммаКомиссии / РеквизитыОплаты.СуммаДокумента; 
					ДокументВозврата.СуммаКомиссии = ДокументВозврата.СуммаДокумента * (ПроцентКомиссии / 100);
				КонецЕсли;
				
			КонецЕсли;
			
			ДокументВозврата.Записать(РежимЗаписиДокумента.Проведение);
			
		КонецЕсли;
		
		Результат = Результат + 1;
		
	КонецЦикла;
	
КонецПроцедуры

// См. ИнтеграцияСЯндексКассойПереопределяемый.ПредопределенныеШаблоныСообщений.
Процедура ПредопределенныеШаблоныСообщений(Шаблоны) Экспорт 
	
	// Демо: Заказ покупателя
	Шаблон = Новый Структура();
	Шаблон.Вставить("ПолноеИмяТипаНазначения", "Документ._ДемоЗаказПокупателя");
	Шаблон.Вставить("Наименование", НСтр("ru = 'Счет на оплату через Яндекс.Кассу (Заказ покупателя)'"));
	Шаблон.Вставить("Тема", НСтр("ru = 'Счет на оплату: [_ДемоЗаказПокупателя.СуммаДокумента] [_ДемоЗаказПокупателя.Валюта].'"));
	ТекстШаблона = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		"<html>
		|<head>
		|<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />
		|<meta http-equiv=""X-UA-Compatible"" content=""IE=Edge"" />
		|<meta name=""format-detection"" content=""telephone=no"" />
		|<style type=""text/css"">
		|body{margin:0;padding:8px;overflow:auto;width:100%;height:100%;}
		|p{line-height:1.15;margin:0;}
		|ol,ul{margin-top:0;margin-bottom:0;}
		|img{border:none;}
		|</style>
		|</head>
		|<body>
		|<p>%1</p>
		|<p><br></p>
		|<p>%2</p>
		|<p><br>
		|</p>
		|<p><br></p>
		|<p>%3</p>
		|<p> </p>
		|<p>%4</p>
		|</body>
		|</html>",
		НСтр("ru = 'Благодарим за заказ и просим оплатить счет.'"),
		НСтр("ru = 'Сумма счета: [_ДемоЗаказПокупателя.СуммаДокумента] [_ДемоЗаказПокупателя.Валюта].'"),
		НСтр("ru = 'Счет можно оплатить, нажав на кнопку'"),
		НСтр("ru = '[_ДемоЗаказПокупателя.КнопкаОплатитьЧерезЯндексКассу]'"));
	Шаблон.Вставить("Текст", ТекстШаблона);
	Шаблоны.Добавить(Шаблон);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Только для служебного использования. Вызывается с помощью ДлительныеОперации.ВыполнитьВФоне.
Процедура ЗагрузитьОперацииПоЯндексКассеВФоне(Знач Параметры, АдресРезультата) Экспорт
	
	Результат = ИнтеграцияСЯндексКассой.ЗагрузитьОперацииПоЯндексКассе(Параметры.Период, Параметры.Организация, Параметры.СДоговором);
	
	ПоместитьВоВременноеХранилище(Результат, АдресРезультата);
	
КонецПроцедуры

Функция НеучтенныеОперации(Знач Операции) 
	
	НеучтенныеОперации = Новый Массив;
	
	ИдентификаторыТранзакций = Новый Массив;
	Для каждого Операция Из Операции Цикл
		ИдентификаторыТранзакций.Добавить(Операция.ИдентификаторТранзакции);
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	УчтенныеОперации.ИдентификаторТранзакции КАК ИдентификаторТранзакции
	|ИЗ
	|	Документ._ДемоОперацияПоЯндексКассе КАК УчтенныеОперации
	|ГДЕ
	|	УчтенныеОперации.ИдентификаторТранзакции В(&ИдентификаторыТранзакций)
	|	И НЕ УчтенныеОперации.ПометкаУдаления";
	Запрос.УстановитьПараметр( "ИдентификаторыТранзакций", ИдентификаторыТранзакций);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	УчтенныеТранзакции = Новый Массив;
	
	Если Не РезультатЗапроса.Пустой() Тогда
		УчтенныеТранзакции = РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("ИдентификаторТранзакции");
	КонецЕсли;
	
	Для каждого Операция Из Операции Цикл
		
		Если УчтенныеТранзакции.Найти(Операция.ИдентификаторТранзакции) = Неопределено Тогда
			НеучтенныеОперации.Добавить(Операция);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат НеучтенныеОперации;
	
КонецФункции

Функция СчетПоИдентификаторуПлатежа(Знач ИдентификаторПлатежа) 
	
	Счет = Неопределено;
	
	ПрефиксДокумента = Лев(ИдентификаторПлатежа, 2);
	
	Если ПрефиксДокумента = "ЗП" Тогда
		
		УИДСтрокой = Сред(ИдентификаторПлатежа, 3);
		
		Если СтроковыеФункцииКлиентСервер.ЭтоУникальныйИдентификатор(УИДСтрокой) Тогда
			
			УИД = Новый УникальныйИдентификатор(УИДСтрокой);
			Счет = Документы._ДемоЗаказПокупателя.ПолучитьСсылку(УИД);
			// Проверим наличие объекта по ссылке, восстановленной из идентификатора.
			Запрос = Новый Запрос;
			Запрос.Текст = 
			"ВЫБРАТЬ
			|	_ДемоЗаказПокупателя.Ссылка КАК Ссылка
			|ИЗ
			|	Документ._ДемоЗаказПокупателя КАК _ДемоЗаказПокупателя
			|ГДЕ
			|	_ДемоЗаказПокупателя.Ссылка = &Ссылка";
			Запрос.УстановитьПараметр("Ссылка", Счет);
			РезультатЗапроса = Запрос.Выполнить();
			
			Если РезультатЗапроса.Пустой() Тогда
				Счет = Неопределено;
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
	Возврат Счет;
	
КонецФункции

Функция ОплатаПоИдентификаторуПлатежа(Знач ИдентификаторПлатежа) 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Операции.Ссылка КАК Оплата
	|ИЗ
	|	Документ._ДемоОперацияПоЯндексКассе КАК Операции
	|ГДЕ
	|	Операции.ХозяйственнаяОперация = &ХозяйственнаяОперацияОплата
	|	И Операции.ИдентификаторПлатежа = &ИдентификаторПлатежа
	|	И НЕ Операции.ПометкаУдаления";
	Запрос.УстановитьПараметр( "ХозяйственнаяОперацияОплата", "Оплата");
	Запрос.УстановитьПараметр( "ИдентификаторПлатежа", ИдентификаторПлатежа);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.Оплата;
	
КонецФункции

#КонецОбласти