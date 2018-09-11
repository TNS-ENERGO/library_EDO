
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая() Тогда
		Объект.Валюта = Константы.ВалютаРегламентированногоУчета.Получить();
		Объект.НомерПоДаннымПоставщика = "";
		Объект.ДатаПоДаннымПоставщика = "";
	КонецЕсли;
	
	// ЭлектронноеВзаимодействие.ОбменСКонтрагентами
	ПараметрыЭДОПриСоздании = ОбменСКонтрагентами.ПараметрыПриСозданииНаСервере_ФормаДокумента();
	ПараметрыЭДОПриСоздании.Форма = ЭтотОбъект;
	ПараметрыЭДОПриСоздании.ДокументСсылка = Объект.Ссылка;
	ПараметрыЭДОПриСоздании.ДекорацияСостояниеЭДО = Элементы.ДекорацияСостояниеЭДО;
	ПараметрыЭДОПриСоздании.ГруппаСостояниеЭДО = Элементы.ГруппаСостояниеЭДО;
	
	ОбменСКонтрагентами.ПриСозданииНаСервере_ФормаДокумента(ПараметрыЭДОПриСоздании);
	// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами

	ИспользуетсяНесколькоОрганизацийЭД = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизацийЭД");
	
	Если Не ИспользуетсяНесколькоОрганизацийЭД И НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
		Объект.Организация = Справочники.Организации.ОрганизацияПоУмолчанию();
	КонецЕсли;
	
	ОбновитьЭлементАдресДоставки(Элементы.АдресДоставки, Объект.СпособДоставки);
	
	// ЭлектронноеВзаимодействие.ТорговыеПредложения
	ТорговыеПредложения.ПриСозданииПодсказокФормы(ЭтотОбъект, Элементы.ПодсказкиБизнесСеть);
	// Конец ЭлектронноеВзаимодействие.ТорговыеПредложения

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// ЭлектронноеВзаимодействие.ОбменСКонтрагентами
	ОбменСКонтрагентамиКлиент.ПриОткрытии(ЭтотОбъект);
	// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами
	
	// ЭлектронноеВзаимодействие.ТорговыеПредложения
	ТорговыеПредложенияКлиент.ОбновитьПодсказкуФормы(ЭтотОбъект);
	// Конец ЭлектронноеВзаимодействие.ТорговыеПредложения
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// ЭлектронноеВзаимодействие.ОбменСКонтрагентами
	ПараметрыПослеЗаписи = ОбменСКонтрагентами.ПараметрыПослеЗаписиНаСервере();
	ПараметрыПослеЗаписи.Форма = ЭтотОбъект;
	ПараметрыПослеЗаписи.ДокументСсылка = Объект.Ссылка;
	ПараметрыПослеЗаписи.ДекорацияСостояниеЭДО = Элементы.ДекорацияСостояниеЭДО;
	ПараметрыПослеЗаписи.ГруппаСостояниеЭДО = Элементы.ГруппаСостояниеЭДО;
	
	ОбменСКонтрагентами.ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи, ПараметрыПослеЗаписи);
	// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ЭлектронноеВзаимодействие.ОбменСКонтрагентами
	ПараметрыОповещения = ОбменСКонтрагентамиКлиент.ПараметрыОповещенияЭДО_ФормаДокумента();
	ПараметрыОповещения.Форма = ЭтотОбъект;
	ПараметрыОповещения.ДокументСсылка = Объект.Ссылка;
	ПараметрыОповещения.ДекорацияСостояниеЭДО = Элементы.ДекорацияСостояниеЭДО;
	ПараметрыОповещения.ГруппаСостояниеЭДО = Элементы.ГруппаСостояниеЭДО;
	
	ОбменСКонтрагентамиКлиент.ОбработкаОповещения_ФормаДокумента(ИмяСобытия, Параметр, Источник, ПараметрыОповещения);
	// Конец ЭлектронноеВзаимодействие.ОбменСКонтрагентами

	Если ИмяСобытия = "ОбновитьДокументИБПослеЗаполнения" И Параметр.Найти(Объект.Ссылка) <> Неопределено Тогда
		Прочитать();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДекорацияЭДОНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбменСКонтрагентамиКлиент.ОткрытьДеревоЭД(Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура СпособДоставкиПриИзменении(Элемент)
	
	ОбновитьЭлементАдресДоставки(Элементы.АдресДоставки, Объект.СпособДоставки);
	
КонецПроцедуры

&НаКлиенте
Процедура АдресДоставкиПриИзменении(Элемент)
	
	// При изменении текста в поле, перезаполнение служебного поля адреса.
	Объект.АдресДоставкиЗначенияПолей =	КонтактнаяИнформацияXMLПоПредставлению(
		Объект.АдресДоставки, ПредопределенноеЗначение("Перечисление.ТипыКонтактнойИнформации.Адрес"));
	
КонецПроцедуры

&НаКлиенте
Процедура АдресДоставкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	// Проверка изменения представления в поле.
	Если Объект.АдресДоставки <> Элементы.АдресДоставки.ТекстРедактирования Тогда
		Объект.АдресДоставки = Элементы.АдресДоставки.ТекстРедактирования;
		Объект.АдресДоставкиЗначенияПолей = КонтактнаяИнформацияXMLПоПредставлению(
			Объект.АдресДоставки, ПредопределенноеЗначение("Перечисление.ТипыКонтактнойИнформации.Адрес"));
		ЭтотОбъект.Модифицированность = Истина;
	КонецЕсли;
	
	АдресДоставкиЗначенияПолей = УправлениеКонтактнойИнформациейКлиентСервер.ПреобразоватьСтрокуВСписокПолей(АдресДоставкиЗначенияПолей);
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ВидКонтактнойИнформации", ПредопределенноеЗначение("Справочник.ВидыКонтактнойИнформации._ДемоАдресСклада"));
	ПараметрыОткрытия.Вставить("ЗначенияПолей",           Объект.АдресДоставкиЗначенияПолей);
	ПараметрыОткрытия.Вставить("Представление",           Объект.АдресДоставки);
	
	Оповещение = Новый ОписаниеОповещения("ОткрытьФормуКонтактнойИнформацииЗавершение", ЭтотОбъект);
		
	УправлениеКонтактнойИнформациейКлиент.ОткрытьФормуКонтактнойИнформации(ПараметрыОткрытия,,Оповещение);
	
КонецПроцедуры

// ЭлектронноеВзаимодействие.ТорговыеПредложения
&НаКлиенте
Процедура Подключаемый_ПодсказкиБизнесСетьНажатие(Элемент)
	
	ТорговыеПредложенияКлиент.ОткрытьФормуПодсказок(ЭтотОбъект);
	
КонецПроцедуры
// Конец ЭлектронноеВзаимодействие.ТорговыеПредложения

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	
	ТекущаяСтрокаСтруктурой = Новый Структура;
	ТекущаяСтрокаСтруктурой.Вставить("ЕдиницаИзмерения");
	ТекущаяСтрокаСтруктурой.Вставить("Номенклатура");
	
	ЗаполнитьЗначенияСвойств(ТекущаяСтрокаСтруктурой, ТекущаяСтрока);
	ОбработатьСтрокуТЧ(ТекущаяСтрокаСтруктурой);
	ЗаполнитьЗначенияСвойств(ТекущаяСтрока, ТекущаяСтрокаСтруктурой);

КонецПроцедуры

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.Сумма = ТекущаяСтрока.Цена * ТекущаяСтрока.Количество;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)

	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	ТекущаяСтрока.Сумма = ТекущаяСтрока.Цена * ТекущаяСтрока.Количество;

КонецПроцедуры // ТоварыЦенаПриИзменении()

&НаКлиенте
Процедура ТоварыСуммаПриИзменении(Элемент)

	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	Если ТекущаяСтрока.Сумма = 0 ИЛИ ТекущаяСтрока.Количество = 0 Тогда
		ТекущаяСтрока.Цена = 0;
	Иначе
		ТекущаяСтрока.Цена = Окр(ТекущаяСтрока.Сумма / ТекущаяСтрока.Количество, 2);
	КонецЕсли;

КонецПроцедуры // ТоварыСуммаПриИзменении()

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуЭДО(Команда)
	
	ЭлектронноеВзаимодействиеКлиент.ВыполнитьПодключаемуюКомандуЭДО(Команда, ЭтотОбъект, Объект);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработчикОжиданияЭДО()
	
	ОбменСКонтрагентамиКлиент.ОбработчикОжиданияЭДО(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбработатьСтрокуТЧ(ТекущаяСтрока)
	
	ТекущаяСтрока.ЕдиницаИзмерения = ТекущаяСтрока.Номенклатура.ЕдиницаИзмерения;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуКонтактнойИнформацииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		// Перенос данных в форму.
		Модифицированность = Истина;
		Объект.АдресДоставкиЗначенияПолей = Результат.КонтактнаяИнформация;
		Объект.АдресДоставки = Результат.Представление;
	КонецЕсли;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьЭлементАдресДоставки(Элемент, СпособДоставки)
	
	Если СпособДоставки = ПредопределенноеЗначение("Перечисление._ДемоСпособыДоставки.Доставка") Тогда
		Элемент.Заголовок = НСтр("ru = 'Адрес доставки'");
		Элемент.АвтоОтметкаНезаполненного = Истина;
	Иначе
		Элемент.Заголовок = НСтр("ru = 'Адрес самовывоза'");
		Элемент.АвтоОтметкаНезаполненного = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция КонтактнаяИнформацияXMLПоПредставлению(Текст, ВидКонтактнойИнформации)
	Возврат УправлениеКонтактнойИнформацией.КонтактнаяИнформацияXMLПоПредставлению(Текст, ВидКонтактнойИнформации);
КонецФункции

#КонецОбласти
