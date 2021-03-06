
#Область СлужебныеПрограммныйИнтерфейс

Процедура УстановитьПараметрКомпоновки(ПараметрыКомпоновки, ИмяПараметра, ЗначениеПараметра) Экспорт
	
	ЭлементПараметра = ПараметрыКомпоновки.Добавить();
	ЭлементПараметра.Имя = ИмяПараметра;
	ЭлементПараметра.Использование = ИспользованиеПараметраКомпоновкиДанных.Всегда;
	ЭлементПараметра.Значение = ЗначениеПараметра;
	
КонецПроцедуры

Функция ПроизвольныйКонтрагент() Экспорт
	
	Контрагент = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Контрагенты.Ссылка КАК Контрагент
	|ИЗ
	|	Справочник.Контрагенты КАК Контрагенты";
	
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		Контрагент = Выборка.Контрагент;
	КонецЕсли;
	
	Возврат Контрагент;
	
КонецФункции

Функция РеквизитыОбменаТоварами() Экспорт
	
	МассивРеквизитов = Новый Массив;
	
	МассивРеквизитов.Добавить("СписокТочекСамовывоза");
	
	Возврат МассивРеквизитов;
	
КонецФункции

Функция РеквизитыОбменаЗаказами() Экспорт
	
	МассивРеквизитов = Новый Массив;
	
	МассивРеквизитов.Добавить("СпособИдентификацииКонтрагентов");
	МассивРеквизитов.Добавить("ЕдиницаИзмеренияНовойНоменклатуры");
	МассивРеквизитов.Добавить("ГруппаДляНовойНоменклатуры");
	МассивРеквизитов.Добавить("ГруппаДляНовыхКонтрагентов");
	МассивРеквизитов.Добавить("Организация");
	МассивРеквизитов.Добавить("НомерНаСайте");
	МассивРеквизитов.Добавить("ДатаНаСайте");
	МассивРеквизитов.Добавить("СоответствиеСтатусовЗаказов");
	
	Возврат МассивРеквизитов;
	
КонецФункции

Функция СоздатьКонтрагента( ДанныеКонтрагента, ПрикладныеПараметры, ОписаниеОшибки) Экспорт
	
	НовыйКонтрагент						= Справочники.Контрагенты.СоздатьЭлемент();
	НовыйКонтрагент.КодПоОКПО			= ДанныеКонтрагента.ОКПО;
	НовыйКонтрагент.ИНН					= ДанныеКонтрагента.ИНН;
	НовыйКонтрагент.КПП					= ДанныеКонтрагента.КПП;
	НовыйКонтрагент.ЮрФизЛицо			= ?(ДанныеКонтрагента.ЮрЛицо, Перечисления.ЮрФизЛицо.ЮрЛицо,
											Перечисления.ЮрФизЛицо.ФизЛицо);
	НовыйКонтрагент.Наименование		= ДанныеКонтрагента.Наименование;
	НовыйКонтрагент.НаименованиеПолное	= ДанныеКонтрагента.ПолноеНаименование;
	НовыйКонтрагент.Родитель			= ПрикладныеПараметры.ГруппаДляНовыхКонтрагентов;
	НовыйКонтрагент.НаименованиеПолное	= ДанныеКонтрагента.ОфициальноеНаименование;	
	НовыйКонтрагент.Записать();
	
	Возврат НовыйКонтрагент.Ссылка;
	
КонецФункции

Процедура НайтиСоздатьЕдиницуИзмерения(ЕдиницаИзмерения,ДанныеЕдиницыИзмерения) Экспорт
	
	КодБазовойЕдиницы = ДанныеЕдиницыИзмерения.КодБазовойЕдиницы;
	Если ЗначениеЗаполнено(КодБазовойЕдиницы)Тогда
		ЕдиницаИзмерения = Справочники.ЕдиницыИзмерения.НайтиПоКоду(КодБазовойЕдиницы);
	КонецЕсли;
	
	НаименованиеБазовойЕдиницы = ДанныеЕдиницыИзмерения.НаименованиеБазовойЕдиницы;
	
	Если ЗначениеЗаполнено(НаименованиеБазовойЕдиницы) И Не ЗначениеЗаполнено(ЕдиницаИзмерения) Тогда
		ЕдиницаИзмерения = Справочники.ЕдиницыИзмерения.НайтиПоНаименованию(НаименованиеБазовойЕдиницы);
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(КодБазовойЕдиницы) И Не ЗначениеЗаполнено(НаименованиеБазовойЕдиницы) Тогда
		Возврат;
	КонецЕсли;
	
	
	Если Не ЗначениеЗаполнено(ЕдиницаИзмерения) Тогда
		ЕдиницаПоКлассификатору = Справочники.ЕдиницыИзмерения.СоздатьЭлемент();
		ЕдиницаПоКлассификатору.Код = "796";
		ЕдиницаПоКлассификатору.Наименование = "Штука";
		ЕдиницаПоКлассификатору.МеждународноеСокращение = "PCE";
		ЕдиницаПоКлассификатору.Записать();
		ЕдиницаПоКлассификатору = ЕдиницаПоКлассификатору.Ссылка;
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьТабличнуюЧастьДокумента(Документ, СтруктураРеквизитовТовары, Параметры) Экспорт
	
	Документ.Товары.Очистить();
	Для Каждого ТекСтрока Из СтруктураРеквизитовТовары Цикл
		
		НоваяСтрока = Документ.Товары.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ТекСтрока);
		НоваяСтрока.Характеристика = ТекСтрока.Характеристика;
	КонецЦикла;
	
КонецПроцедуры

// Ищет валюту по коду
//
Процедура ОбработатьВалютуXML(Валюта,КодВалютыСтрока) Экспорт
		
	Валюта = Справочники.Валюты.НайтиПоНаименованию(КодВалютыСтрока);
	
	Если НЕ ЗначениеЗаполнено(Валюта) Тогда
		Валюта = Константы.ВалютаРегламентированногоУчета.Получить();
	КонецЕсли;
	
КонецПроцедуры

Процедура ПолучитьЗначенияСвойств(ТаблицаСвойств, ЗаказПокупателя) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДополнительныеСведения.Свойство,
	|	ДополнительныеСведения.Значение
	|ИЗ
	|	РегистрСведений._ДемоДополнительныеСведения КАК ДополнительныеСведения
	|ГДЕ
	|	ДополнительныеСведения.Свойство.ЭтоДополнительноеСведение = ИСТИНА
	|	И ДополнительныеСведения.Объект = &Ссылка";
	Запрос.УстановитьПараметр("Ссылка",ЗаказПокупателя);
	ТаблицаСвойств = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

Функция НайтиНоменклатуруПоАртикулуНаименованию(Артикул, Наименование) Экспорт
	
	Если ЗначениеЗаполнено(Артикул) Тогда
		
		Запрос = Новый Запрос(
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.Артикул = &Артикул
		|	И НЕ Номенклатура.ЭтоГруппа");
		
		Запрос.УстановитьПараметр("Артикул", Артикул);
		
	ИначеЕсли ЗначениеЗаполнено(Наименование) Тогда
		
		Запрос = Новый Запрос(
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.Наименование = &Наименование
		|	И НЕ Номенклатура.ЭтоГруппа");
		
		Запрос.УстановитьПараметр("Наименование", Наименование);
		
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат Результат.Выгрузить()[0][0];
		
КонецФункции

// По значению процента налога определяет ставку НДС.
// Параметры:
// СтавкаНалогаСтавка. Тип - строка. Строковое представление значения ставки ,например, "18","10".
// ЗначениеСтавки. Тип - перечисление ссылка, Справочник Ссылка, значение ставки НДС, выраженное элементов метаданных прикладного решения.
//
Процедура ПолучитьПоЗначениюДляВыгрузкиСтавкуНДС(СтавкаНалогаСтавка, ЗначениеСтавки) Экспорт
	
	Если СтавкаНалогаСтавка = "18" Тогда
		ЗначениеСтавки = Перечисления.СтавкиНДС.НДС18;
	Иначе
		ЗначениеСтавки = Перечисления.СтавкиНДС.НДС10;
	КонецЕсли;
		
КонецПроцедуры

Процедура ЗафиксироватьИзменениеТоваровПоСкладамПриПроведении(Источник, Отказ, РежимПроведения) Экспорт
	
	ТипИсточника = ТипЗнч(Источник);
	Если ТипИсточника = Тип("ДокументОбъект.РеализацияТоваровУслуг") Тогда
		
		Источник.Движения._ДемоТоварыНаСкладах.Записывать = Истина;
		Для Каждого СтрокаТаблицы Из Источник.Товары Цикл
			Движение = Источник.Движения._ДемоТоварыНаСкладах.Добавить();
			Движение.ВидДвижения    = ВидДвиженияНакопления.Расход;
			Движение.Период         = Источник.Дата;
			Движение.Номенклатура   = СтрокаТаблицы.Номенклатура;
			Движение.Характеристика = СтрокаТаблицы.Характеристика;
			Движение.Количество     = СтрокаТаблицы.Количество;
		КонецЦикла;
		
	ИначеЕсли ТипИсточника = Тип("ДокументОбъект.ПоступлениеТоваровУслуг") Тогда
		
		Источник.Движения._ДемоТоварыНаСкладах.Записывать = Истина;
		Для Каждого СтрокаТаблицы Из Источник.Товары Цикл
			Движение = Источник.Движения._ДемоТоварыНаСкладах.Добавить();
			Движение.ВидДвижения    = ВидДвиженияНакопления.Приход;
			Движение.Период         = Источник.Дата;
			Движение.Номенклатура   = СтрокаТаблицы.Номенклатура;
			Движение.Характеристика = СтрокаТаблицы.Характеристика;
			Движение.Количество     = СтрокаТаблицы.Количество;
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти