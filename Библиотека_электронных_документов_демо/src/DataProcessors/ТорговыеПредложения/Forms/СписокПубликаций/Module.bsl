
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьУсловноеОформление();
	 
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ИспользоватьВидыНоменклатуры = Ложь;
	ТорговыеПредложенияПереопределяемый.ФункциональнаяОпцияИспользуется(ИмяФормы, ИспользоватьВидыНоменклатуры);
	Если Не ИспользоватьВидыНоменклатуры Тогда
		ТорговыеПредложенияПереопределяемый.СообщитьОНеобходимостиИспользованияФункциональнойОпции(
			ИмяФормы, ИспользоватьВидыНоменклатуры, Отказ);
		Возврат;
	КонецЕсли;
	
	ТаблицаТорговыхПредложений = Метаданные.НайтиПоТипу(Метаданные.ОпределяемыеТипы.ТорговоеПредложение.Тип.Типы()[0]);
	ЕстьПравоПросмотраТаблицыТорговыхПредложений = ПравоДоступа("Просмотр", ТаблицаТорговыхПредложений);
	Элементы.Добавить.Доступность = ЕстьПравоПросмотраТаблицыТорговыхПредложений;
	УстановитьЗапросДинамическогоСписка(ТаблицаТорговыхПредложений);
	
	ЗаполнитьСписокЗарегистрированныхОрганизаций();
	
	АвтоматическиСинхронизировать = АвтоматическаяСинхронизацияВключена();
	Элементы.Расписание.Заголовок = ТекущееРасписание();
	Элементы.Расписание.Доступность = АвтоматическиСинхронизировать;
	Элементы.НастроитьРасписание.Доступность = АвтоматическиСинхронизировать;
	
	Если ОбщегоНазначения.РазделениеВключено() Тогда
		Элементы.НастроитьРасписание.Видимость = Ложь;
		Элементы.Расписание.Видимость = Ложь;
	КонецЕсли;
	
	ИмяОбъектаСоглашения = "Справочник." + Метаданные.НайтиПоТипу(Метаданные.РегистрыСведений.
		СостоянияСинхронизацииТорговыеПредложения.Измерения.ТорговоеПредложение.Тип.Типы()[0]).Имя;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	ОбработкаВыбораНаСервере(ВыбранноеЗначение);
	Элементы.Список.Обновить();
	
	Оповестить("ТорговыеПредложения_ИзменениеСинхронизации", ВыбранноеЗначение, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ТорговыеПредложения_ПослеЗаписи" Тогда
		
		Элементы.Список.Обновить();
		
	ИначеЕсли ИмяСобытия = "СинхронизацияТорговыхПредложений_ПриИзменении" Тогда
		
		АвтоматическиСинхронизировать = АвтоматическаяСинхронизацияВключена();
		Элементы.Расписание.Заголовок = ТекущееРасписание();
		Элементы.Расписание.Доступность = АвтоматическиСинхронизировать;
		Элементы.НастроитьРасписание.Доступность = АвтоматическиСинхронизировать;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ОчиститьСообщения();
	
	СтандартнаяОбработка = Ложь;
	Если Элементы.Список.ТекущиеДанные <> Неопределено Тогда
		
		ПоляДополнительныхНастроек = "СписокАдресЭлектроннойПочты, СписокДополнительноеОписание,
			|СписокПубликоватьЦены, СписокПубликоватьСрокиПоставки, СписокПубликоватьОстатки";
		Если СтрНайти(ПоляДополнительныхНастроек, Поле.Имя) Тогда
			ОткрываемаяФорма = "РегистрСведений.СостоянияСинхронизацииТорговыеПредложения.Форма.НастройкиПубликации";
			ПараметрыОткрытияФормы = Новый Структура;
			ПараметрыОткрытияФормы.Вставить("ТорговоеПредложение", Элементы.Список.ТекущиеДанные.ТорговоеПредложение);
			ОткрытьФорму(ОткрываемаяФорма, ПараметрыОткрытияФормы, ЭтотОбъект);
		Иначе
			ОчиститьСообщения();
			ОткрытьФорму(ИмяОбъектаСоглашения + ".ФормаОбъекта", Новый Структура("Ключ", Элементы.Список.ТекущиеДанные.ТорговоеПредложение));
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередУдалением(Элемент, Отказ)
	
	УдалитьПубликацию(Элемент, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Добавить(Команда)
	
	Отбор = Новый Структура;
	Отбор.Вставить("Организация", ЗарегистрированныеОрганизации);
	ОчиститьСообщения();
	ОткрытьФорму(ИмяОбъектаСоглашения + ".ФормаВыбора", Новый Структура("Отбор", Отбор),ЭтотОбъект, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьПубликацию(Элемент, Отказ = Неопределено)

	Отказ = Истина;
	
	Если Элементы.Список.ТекущиеДанные <> Неопределено Тогда
		
		УдалитьПубликациюЗавершениеВопроса = Новый ОписаниеОповещения("УдалитьПубликациюЗавершениеВопроса",
			ЭтотОбъект, Элементы.Список.ТекущиеДанные.ТорговоеПредложение);
			
		Если Элементы.Список.ТекущиеДанные.ДействиеСинхронизации = ПредопределенноеЗначение("Перечисление.ДействияСинхронизацииТорговыеПредложения.Удаление") Тогда 
			Действие = НСтр("ru = 'Вернуть'");
		Иначе
			Действие = НСтр("ru = 'Отменить'");
		КонецЕсли;
			
		ТекстВопроса = СтрШаблон(НСтр("ru = '%1 публикацию торгового предложения?'"), Действие);
		
		ПоказатьВопрос(УдалитьПубликациюЗавершениеВопроса,
			ТекстВопроса, РежимДиалогаВопрос.ДаНет, 60, КодВозвратаДиалога.Да, НСтр("ru = 'Отмена/возврат публикации.'")); 
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СинхронизироватьТорговыеПредложения(Команда)
	
	ОчиститьСообщения();
	
	ДлительнаяОперация = СинхронизацияТорговыхПредложенийВФоне();
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Неопределено);
	ПараметрыОжидания.ВыводитьСообщения = Истина;
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация,
		Новый ОписаниеОповещения("СинхронизироватьТорговыеПредложенияЗавершение", ЭтотОбъект), ПараметрыОжидания);
	
КонецПроцедуры

&НаКлиенте
Процедура НастроитьРасписание(Команда)
	
	ДиалогРасписания = Новый ДиалогРасписанияРегламентногоЗадания(ТекущееРасписание());
	ОписаниеОповещения = Новый ОписаниеОповещения("НастроитьРасписаниеЗавершение", ЭтотОбъект);
	ДиалогРасписания.Показать(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура АвтоматическиСинхронизироватьПриИзменении(Элемент)
	
	УстановитьПараметрРегламентногоЗадания("Использование", АвтоматическиСинхронизировать);
	Элементы.Расписание.Доступность = АвтоматическиСинхронизировать;
	Элементы.НастроитьРасписание.Доступность = АвтоматическиСинхронизировать;
	
	Оповестить("СинхронизацияТорговыхПредложений_ПриИзменении");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтчетПубликуемыеТорговыеПредложения(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Отбор = Новый Структура("ТорговоеПредложение", ТекущиеДанные.ТорговоеПредложение);
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор", Отбор);
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	
	ОчиститьСообщения();
	ОткрытьФорму("Отчет.ПубликуемыеТорговыеПредложения.Форма", ПараметрыФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ПригласитьПокупателей(Команда)
	
	ОчиститьСообщения();
	
	// Приглашение покупателей в сервис.
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("РежимПриглашения", "Покупатели");
	ОткрытьФорму("Обработка.БизнесСеть.Форма.ОтправкаПриглашенийКонтрагентам", ПараметрыОткрытия);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


&НаКлиенте
Процедура УдалитьПубликациюЗавершениеВопроса(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ПометитьСнятьКУдалениюТорговоеПредложение(ДополнительныеПараметры);
		Элементы.Список.Обновить();
		
		Оповестить("ТорговыеПредложения_ИзменениеСинхронизации", ДополнительныеПараметры, ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОбработкаВыбораНаСервере(ТорговоеПредложение, ДополнительныеПараметры = Неопределено)
	
	Отбор = Новый Структура("ТорговоеПредложение", ТорговоеПредложение);
	Выборка = РегистрыСведений.СостоянияСинхронизацииТорговыеПредложения.Выбрать(Отбор);
	
	Если Не Выборка.Следующий() Тогда
		МенеджерЗаписи = РегистрыСведений.СостоянияСинхронизацииТорговыеПредложения.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.ТорговоеПредложение = ТорговоеПредложение;
		
		// Заполнение организации.
		СвойстваПредложения = Новый Структура("Организация, Валюта");
		ТорговыеПредложенияПереопределяемый.ПолучитьСвойстваТорговогоПредложения(ТорговоеПредложение, СвойстваПредложения);
		МенеджерЗаписи.Организация = СвойстваПредложения.Организация;
		
		МенеджерЗаписи.Состояние = Перечисления.СостоянияСинхронизацииТорговыеПредложения.ТребуетсяСинхронизация;
		МенеджерЗаписи.Записать();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СинхронизироватьТорговыеПредложенияЗавершение(Результат, ДополнительныеПараметры) Экспорт 
	
	Если Результат = Неопределено Тогда // отменено пользователем.
		Возврат;
	КонецЕсли;
	
	Если Результат.Свойство("Сообщения") Тогда
		Для каждого Сообщение Из Результат.Сообщения Цикл 
			Сообщение.Сообщить();
		КонецЦикла;
	КонецЕсли;
	
	Если Результат.Статус = "Ошибка" Тогда
		ТекстСообщения = Результат.ПодробноеПредставлениеОшибки;
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = '%1 %2'"),
				ОбщегоНазначенияКлиент.ДатаСеанса(), ТекстСообщения));
	КонецЕсли;
		
	Элементы.Список.Обновить();
	
	Оповестить("ТорговыеПредложения_ИзменениеСинхронизации",, ЭтотОбъект);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПометитьСнятьКУдалениюТорговоеПредложение(ТорговоеПредложение)
	
	Отбор = Новый Структура("ТорговоеПредложение", ТорговоеПредложение);
	Выборка = РегистрыСведений.СостоянияСинхронизацииТорговыеПредложения.Выбрать(Отбор);
	
	Если Выборка.Следующий() Тогда 
		МенеджерЗаписи = Выборка.ПолучитьМенеджерЗаписи();
		МенеджерЗаписи.ДействиеСинхронизации = 
			?(Выборка.ДействиеСинхронизации = Перечисления.ДействияСинхронизацииТорговыеПредложения.Удаление,
				Перечисления.ДействияСинхронизацииТорговыеПредложения.Изменение,
				Перечисления.ДействияСинхронизацииТорговыеПредложения.Удаление);
		МенеджерЗаписи.Состояние = Перечисления.СостоянияСинхронизацииТорговыеПредложения.ТребуетсяСинхронизация;
		МенеджерЗаписи.ДатаСинхронизации = '00010101';
		МенеджерЗаписи.Записать();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	
	// Оформление.
	УсловноеОформление.Элементы.Очистить();
	
	// Отображение информации об ошибке.
	Элемент = УсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Отображение информации об ошибке'");
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.СписокОписаниеОшибки.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Список.Состояние");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеРавно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.СостоянияСинхронизацииТорговыеПредложения.ОшибкаСинхронизации;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Видимость", Ложь);
	
	// Представление состояния при статусе к удалению.
	Элемент = УсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Представление состояния при статусе к удалению'");
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.СписокСостояние.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Список.ДействиеСинхронизации");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ДействияСинхронизацииТорговыеПредложения.Удаление;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = 'Отмена публикации. Требуется синхронизация'"));
	
	// Цвет текста при статусе к удалению.
	Элемент = УсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Цвет текста при статусе к удалению'");
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.Список.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Список.ДействиеСинхронизации");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Перечисления.ДействияСинхронизацииТорговыеПредложения.Удаление;

	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.НедоступныеДанныеЭДЦвет);
	
	// Представление пустого значения почты для уведомления.
	Элемент = УсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Представление пустого значения электронной почты для уведомления'");
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.СписокАдресЭлектроннойПочты.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Список.УведомлятьОЗаказах");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Ложь;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = '<отключено>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.НедоступныеДанныеЭДЦвет);
	
	// Представление пустого значения описания для описания.
	Элемент = УсловноеОформление.Элементы.Добавить();
	Элемент.Представление = НСтр("ru = 'Представление пустого дополнительного описания'");
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.СписокДополнительноеОписание.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Список.ДополнительноеОписание");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = '<Укажите описание>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветТекста", ЦветаСтиля.НедоступныеДанныеЭДЦвет);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокЗарегистрированныхОрганизаций()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ОрганизацииБизнесСеть.Организация КАК Организация
	|ИЗ
	|	РегистрСведений.ОрганизацииБизнесСеть КАК ОрганизацииБизнесСеть";
	ЗарегистрированныеОрганизации.ЗагрузитьЗначения(
		Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Организация"));
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьСопоставлениеНоменклатуры(Команда)
	
	ОчиститьСообщения();
	ОткрытьФорму("Обработка.ТорговыеПредложения.Форма.СопоставлениеНоменклатуры");
	
КонецПроцедуры

&НаСервере
Функция АвтоматическаяСинхронизацияВключена()
	
	Возврат ПолучитьПараметрРегламентногоЗадания("Использование", Ложь);
	
КонецФункции

&НаСервере
Процедура УстановитьПараметрРегламентногоЗадания(ИмяПараметра, ЗначениеПараметра)
	
	БизнесСеть.ИзменитьРегламентноеЗадание(Метаданные.РегламентныеЗадания.СинхронизацияТорговыхПредложений.Имя,
		ИмяПараметра, ЗначениеПараметра);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПараметрРегламентногоЗадания(ИмяПараметра, ЗначениеПоУмолчанию)
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Метаданные", Метаданные.РегламентныеЗадания.СинхронизацияТорговыхПредложений);
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		ПараметрыЗадания.Вставить("ИмяМетода", Метаданные.РегламентныеЗадания.СинхронизацияТорговыхПредложений.ИмяМетода);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	СписокЗаданий = РегламентныеЗаданияСервер.НайтиЗадания(ПараметрыЗадания);
	Для каждого Задание Из СписокЗаданий Цикл
		Возврат Задание[ИмяПараметра];
	КонецЦикла;
	
	Возврат ЗначениеПоУмолчанию;
	
КонецФункции

&НаСервере
Функция ТекущееРасписание()
	
	Возврат ПолучитьПараметрРегламентногоЗадания("Расписание", Новый РасписаниеРегламентногоЗадания);
	
КонецФункции

&НаКлиенте
Процедура НастроитьРасписаниеЗавершение(Расписание, ДополнительныеПараметры) Экспорт
	
	Если Расписание = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПараметрРегламентногоЗадания("Расписание", Расписание);
	Элементы.Расписание.Заголовок = Расписание;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗапросДинамическогоСписка(ТаблицаТорговыхПредложений)
	
	ОсновнаяТаблица = ТаблицаТорговыхПредложений.ПолноеИмя();
	ТекстЗапросаСписка =
	"ВЫБРАТЬ
	|	СостояниеСинхронизации.ТорговоеПредложение КАК ТорговоеПредложение,
	|	СостояниеСинхронизации.ДатаСинхронизации КАК ДатаСинхронизации,
	|	СостояниеСинхронизации.Состояние КАК Состояние,
	|	СостояниеСинхронизации.ДействиеСинхронизации КАК ДействиеСинхронизации,
	|	СостояниеСинхронизации.ОписаниеОшибки КАК ОписаниеОшибки,
	|	СостояниеСинхронизации.УведомлятьОЗаказах КАК УведомлятьОЗаказах,
	|	СостояниеСинхронизации.АдресЭлектроннойПочты КАК АдресЭлектроннойПочты,
	|	СостояниеСинхронизации.ДополнительноеОписание КАК ДополнительноеОписание,
	|	СостояниеСинхронизации.Организация КАК Организация,
	|	ПРЕДСТАВЛЕНИЕ(СостояниеСинхронизации.ТорговоеПредложение) КАК Наименование,
	|	ВЫБОР
	|		КОГДА СостояниеСинхронизации.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияСинхронизацииТорговыеПредложения.Синхронизировано)
	|			ТОГДА 0
	|		КОГДА СостояниеСинхронизации.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияСинхронизацииТорговыеПредложения.ТребуетсяСинхронизация)
	|			ТОГДА 1
	|		ИНАЧЕ 2
	|	КОНЕЦ КАК НомерКартинкиСтроки,
	|	СостояниеСинхронизации.ПубликоватьЦены КАК ПубликоватьЦены,
	|	СостояниеСинхронизации.ПубликоватьСрокиПоставки КАК ПубликоватьСрокиПоставки,
	|	СостояниеСинхронизации.ПубликоватьОстатки КАК ПубликоватьОстатки
	|ИЗ
	|	РегистрСведений.СостоянияСинхронизацииТорговыеПредложения КАК СостояниеСинхронизации
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ТаблицаТорговыхПредложений КАК ТорговыеПредложения
	|		ПО СостояниеСинхронизации.ТорговоеПредложение = ТорговыеПредложения.Ссылка";
	ТекстЗапросаСписка = СтрЗаменить(ТекстЗапросаСписка, "ТаблицаТорговыхПредложений", ОсновнаяТаблица);
	
	СвойстваСписка = ОбщегоНазначения.СтруктураСвойствДинамическогоСписка();
	СвойстваСписка.ОсновнаяТаблица              = ОсновнаяТаблица;
	СвойстваСписка.ТекстЗапроса                 = ТекстЗапросаСписка;
	СвойстваСписка.ДинамическоеСчитываниеДанных = Истина;
	ОбщегоНазначения.УстановитьСвойстваДинамическогоСписка(Элементы.Список, СвойстваСписка);

КонецПроцедуры

&НаСервере
Функция СинхронизацияТорговыхПредложенийВФоне()
		
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(Новый УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru = 'Синхронизация торговых предложений с сервисом 1С:Бизнес-сеть'");
	
	Возврат ДлительныеОперации.ВыполнитьВФоне("ТорговыеПредложения.СинхронизацияТорговыхПредложений",
		Неопределено, ПараметрыВыполнения);
	
КонецФункции

#КонецОбласти