#Область ПрограммныйИнтерфейс

// Заполняет виды доступа, используемые в ограничениях прав доступа.
// Примечание: виды доступа Пользователи и ВнешниеПользователи предопределены,
// но их можно удалить из списка ВидыДоступа, если они не требуются для ограничения прав доступа.
//
// Параметры:
//  ВидыДоступа - ТаблицаЗначений - с колонками:
//   * Имя                    - Строка - имя используемое в описании поставляемых
//                                       профилей групп доступа и текстах ОДД.
//   * Представление          - Строка - представляет вид доступа в профилях и группах доступа.
//   * ТипЗначений            - Тип    - тип ссылки значений доступа,
//                                       например, Тип("СправочникСсылка.Номенклатура").
//   * ТипГруппЗначений       - Тип    - тип ссылки групп значений доступа,
//                                       например, Тип("СправочникСсылка.ГруппыДоступаНоменклатуры").
//   * НесколькоГруппЗначений - Булево - Истина указывает, что для значения доступа (Номенклатуры), можно
//                                       выбрать несколько групп значений (Групп доступа номенклатуры).
//
// Пример:
//  1. Для настройки прав доступа в разрезе организаций:
//  ВидДоступа = ВидыДоступа.Добавить();
//  ВидДоступа.Имя = "Организации";
//  ВидДоступа.Представление = НСтр("ru = 'Организации'");
//  ВидДоступа.ТипЗначений   = Тип("СправочникСсылка.Организации");
//
//  2. Для настройки прав доступа в разрезе групп партнеров:
//  ВидДоступа = ВидыДоступа.Добавить();
//  ВидДоступа.Имя = "ГруппыПартнеров";
//  ВидДоступа.Представление    = НСтр("ru = 'Группы партнеров'");
//  ВидДоступа.ТипЗначений      = Тип("СправочникСсылка.Партнеры");
//  ВидДоступа.ТипГруппЗначений = Тип("СправочникСсылка.ГруппыДоступаПартнеров");
//
Процедура ПриЗаполненииВидовДоступа(ВидыДоступа) Экспорт
	
	// КлиентЭДО начало
	УправлениеДоступомКЭДО.ПриЗаполненииВидовДоступа(ВидыДоступа);
	// КлиентЭДО конец
	
КонецПроцедуры

// Заполняет описания поставляемых профилей групп доступа и
// переопределяет параметры обновления профилей и групп доступа.
//
// Для автоматической подготовки содержимого процедуры следует воспользоваться инструментами
// разработчика для подсистемы Управление доступом.
//
// Параметры:
//  ОписанияПрофилей    - Массив - добавить описания профилей групп доступа (Структура).
//                        Состав свойств структуры см. УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа.
//
//  ПараметрыОбновления - Структура - содержит свойства:
//   * ОбновлятьИзмененныеПрофили - Булево - начальное значение Истина.
//   * ЗапретитьИзменениеПрофилей - Булево - начальное значение Истина.
//       Если установить Ложь, тогда поставляемые профили можно не только просматривать, но и редактировать.
//   * ОбновлятьГруппыДоступа     - Булево - начальное значение Истина.
//   * ОбновлятьГруппыДоступаСУстаревшимиНастройками - Булево - начальное значение Ложь.
//       Если установить Истина, то настройки значений, выполненные администратором для
//       вида доступа который был удален из профиля, будут также удалены из групп доступа.
//
// Пример:
//  ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
//  ОписаниеПрофиля.Имя           = "Менеджер";
//  ОписаниеПрофиля.Идентификатор = "75fa0ecb-98aa-11df-b54f-e0cb4ed5f655";
//  ОписаниеПрофиля.Наименование  = НСтр("ru = 'Менеджер по продажам'", Метаданные.ОсновнойЯзык.КодЯзыка);
//  ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
//  ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
//  ОписаниеПрофиля.Роли.Добавить("БазовыеПрава");
//  ОписаниеПрофиля.Роли.Добавить("Подсистема_Продажи");
//  ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДокументовПокупателей");
//  ОписаниеПрофиля.Роли.Добавить("ПросмотрОтчетаКнигаПокупок");
//  ОписанияПрофилей.Добавить(ОписаниеПрофиля);
//
Процедура ПриЗаполненииПоставляемыхПрофилейГруппДоступа(ОписанияПрофилей, ПараметрыОбновления) Экспорт
	
	// КлиентЭДО начало
	 УправлениеДоступомКЭДО.ПриЗаполненииПоставляемыхПрофилейГруппДоступа(ОписанияПрофилей, ПараметрыОбновления);
	// КлиентЭДО конец
	
	// _Демо начало примера
	
	ПриЗаполненииПоставляемыхПрофилейГруппДоступаОбменСБанками(ОписанияПрофилей, ПараметрыОбновления);
	
	Для Каждого ОписаниеПрофиля Из ОписанияПрофилей Цикл
		ОписаниеПрофиля.Роли.Добавить("_ДемоБазовыеПраваБЭД");
	КонецЦикла;
	
	// ЭлектронноеВзаимодействие.БизнесСеть
	ПриЗаполненииПоставляемыхПрофилейГруппДоступаБизнесСеть(ОписанияПрофилей, ПараметрыОбновления);
	// Конец ЭлектронноеВзаимодействие.БизнесСеть
	
	// ЭлектронноеВзаимодействие.ИнтеграцияСЯндексКассой
	ПриЗаполненииПоставляемыхПрофилейГруппДоступаИнтеграцияСЯндексКассой(ОписанияПрофилей, ПараметрыОбновления);
	// Конец ЭлектронноеВзаимодействие.ИнтеграцияСЯндексКассой
	
	// _Демо конец примера
	
КонецПроцедуры

// Заполняет зависимости прав доступа "подчиненного" объекта, например, задачи ЗадачаИсполнителя,
// от "ведущего" объекта, например,  бизнес-процесса Задание, которые отличаются от стандартных.
//
// Зависимости прав используются в стандартном шаблоне ограничения доступа для вида доступа "Объект".
// 1. Стандартно при чтении "подчиненного" объекта
//    проверяется наличие права чтения "ведущего" объекта и
//    проверяется отсутствие ограничения чтения "ведущего" объекта.
// 2. Стандартно при добавлении, изменении, удалении "подчиненного" объекта
//    проверяется наличие права изменения "ведущего" объекта и
//    проверяется отсутствие ограничения изменения "ведущего" объекта.
//
// Допускается только одно переназначение по сравнению со стандартным -
// в пункте "2)" вместо проверки права изменения "ведущего" объекта установить
// проверку права чтения "ведущего" объекта.
//
// Параметры:
//  ЗависимостиПрав - ТаблицаЗначений - с колонками:
//   * ВедущаяТаблица     - Строка - например, Метаданные.БизнесПроцессы.Задание.ПолноеИмя().
//   * ПодчиненнаяТаблица - Строка - например, Метаданные.Задачи.ЗадачаИсполнителя.ПолноеИмя().
//
Процедура ПриЗаполненииЗависимостейПравДоступа(ЗависимостиПрав) Экспорт
	
	
	
КонецПроцедуры

// Заполняет описания возможных прав, назначаемых для объектов, указанных типов.
// 
// Параметры:
//  ВозможныеПрава - ТаблицаЗначений - с колонками:
//   ВладелецПрав - Строка - полное имя таблицы значения доступа.
//
//   Имя          - Строка - идентификатор права, например, ИзменениеПапок. Право с именем УправлениеПравами
//                  должно быть обязательно определено для общей формы настройки прав "Права доступа".
//                  УправлениеПравами - это право на изменение прав по владельцу прав, которое проверяется
//                  при открытии РегистрСведений.НастройкиПравОбъектов.Форма.НастройкиПравОбъектов.
//
//   Заголовок    - Строка - заголовок права, например в форме НастройкиПравОбъектов:
//                  "Изменение.
//                  |папок".
//
//   Подсказка    - Строка - подсказка к заголовку права,
//                  например, "Добавление, изменение и пометка удаления папок".
//
//   НачальноеЗначение - Булево - начальное значение флажка права при добавлении новой строки
//                  в форме "Права доступа".
//
//   ТребуемыеПрава - Массив строк - имена прав, требуемых для от этого права,
//                  например, право "ДобавлениеФайлов" требует право "ИзменениеФайлов".
//
//   ЧтениеВТаблицах - Массив строк - полные имена таблиц, для которых это право обозначает право Чтение.
//                  Возможно использование символа "*", который обозначает "для всех остальных таблиц"
//                  т.к. право Чтение может зависеть только от права Чтение, то имеет смысл только символ "*"
//                  (требуется для работы шаблонов ограничения доступа).
//
//   ИзменениеВТаблицах - Массив строк - полные имена таблиц, для которых это право обозначает право Изменение.
//                  Возможно использование символа "*", который обозначает "для всех остальных таблиц"
//                  (требуется для работы шаблонов ограничения доступа).
//
Процедура ПриЗаполненииВозможныхПравДляНастройкиПравОбъектов(ВозможныеПрава) Экспорт
	
КонецПроцедуры

// Определяет вид используемого интерфейса пользователя для настройки доступа.
//
// Параметры:
//  УпрощенныйИнтерфейс - Булево - начальное значение Ложь.
//
Процедура ПриОпределенииИнтерфейсаНастройкиДоступа(УпрощенныйИнтерфейс) Экспорт
	
КонецПроцедуры

// Заполняет использование видов доступа в зависимости от функциональных опций конфигурации,
// например, ИспользоватьГруппыДоступаНоменклатуры.
//
// Параметры:
//  ВидДоступа    - Строка - имя вида доступа заданное в процедуре ПриЗаполненииВидовДоступа.
//  Использование - Булево - начальное значение Истина.
// 
Процедура ПриЗаполненииИспользованияВидаДоступа(ВидДоступа, Использование) Экспорт
	
	
	
КонецПроцедуры

// Заполняет состав видов доступа, используемых при ограничении прав объектов метаданных.
// Если состав видов доступа не заполнен, отчет "Права доступа" покажет некорректные сведения.
//
// Обязательно требуется заполнить только виды доступа, используемые в шаблонах ограничения доступа
// явно, а виды доступа, используемые в наборах значений доступа могут быть получены из текущего
// состояния регистра сведений НаборыЗначенийДоступа.
//
//  Для автоматической подготовки содержимого процедуры следует воспользоваться инструментами
// разработчика для подсистемы Управление доступом.
//
// Параметры:
//  Описание     - Строка - многострочная строка формата <Таблица>.<Право>.<ВидДоступа>[.Таблица объекта],
//                 например, "Документ.ПриходнаяНакладная.Чтение.Организации",
//                           "Документ.ПриходнаяНакладная.Чтение.Контрагенты",
//                           "Документ.ПриходнаяНакладная.Изменение.Организации",
//                           "Документ.ПриходнаяНакладная.Изменение.Контрагенты",
//                           "Документ.ЭлектронныеПисьма.Чтение.Объект.Документ.ЭлектронныеПисьма",
//                           "Документ.ЭлектронныеПисьма.Изменение.Объект.Документ.ЭлектронныеПисьма",
//                           "Документ.Файлы.Чтение.Объект.Справочник.ПапкиФайлов",
//                           "Документ.Файлы.Чтение.Объект.Документ.ЭлектронноеПисьмо",
//                           "Документ.Файлы.Изменение.Объект.Справочник.ПапкиФайлов",
//                           "Документ.Файлы.Изменение.Объект.Документ.ЭлектронноеПисьмо".
//                 Вид доступа Объект предопределен, как литерал. Этот вид доступа используется в
//                 шаблонах ограничений доступа, как "ссылка" на другой объект, по которому
//                 ограничивается текущий объект таблицы.
//                 Когда вид доступа "Объект" задан, также требуется задать типы таблиц,
//                 которые используются для этого вида доступа. Т.е. перечислить типы,
//                 которые соответствуют полю, использованному в шаблоне ограничения доступа
//                 в паре с видом доступа "Объект". При перечислении типов по виду доступа "Объект"
//                 нужно перечислить только те типы поля, которые есть
//                 у поля РегистрыСведений.НаборыЗначенийДоступа.Объект, остальные типы лишние.
// 
Процедура ПриЗаполненииВидовОграниченийПравОбъектовМетаданных(Описание) Экспорт
	
	
	
КонецПроцедуры

// Позволяет реализовать перезапись зависимых наборов значений доступа других объектов.
//
// Вызывается из процедур
//  УправлениеДоступомСлужебный.ЗаписатьНаборыЗначенийДоступа,
//  УправлениеДоступомСлужебный.ЗаписатьЗависимыеНаборыЗначенийДоступа.
//
// Параметры:
//  Ссылка       - СправочникСсылка, ДокументСсылка, ... - ссылка на объект, для которого
//                 записаны наборы значений доступа.
//
//  СсылкиНаЗависимыеОбъекты - Массив - массив элементов типа СправочникСсылка, ДокументСсылка, ...
//                 Содержит ссылки на объекты с зависимыми наборами значений доступа.
//                 Начальное значение - пустой массив.
//
Процедура ПриИзмененииНаборовЗначенийДоступа(Ссылка, СсылкиНаЗависимыеОбъекты) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти


// _Демо начало примера

Процедура ПриЗаполненииПоставляемыхПрофилейГруппДоступаОбменСБанками(ОписанияПрофилей, ПараметрыОбновления)
	
	Для Каждого ОписаниеПрофиля Из ОписанияПрофилей Цикл
		Если ОписаниеПрофиля.Имя = "Пользователь" Тогда
			ОписаниеПрофиля.Роли.Добавить("ЧтениеНастроекОбменСБанками");
			ОписаниеПрофиля.Роли.Добавить("ЧтениеОбменСБанками");
		ИначеЕсли ОписаниеПрофиля.Имя = "Менеджер" Тогда
			ОписаниеПрофиля.Роли.Добавить("ВыполнениеОбменаОбменСБанками");
			ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеОбменСБанками");
			ОписаниеПрофиля.Роли.Добавить("ЧтениеНастроекОбменСБанками");
		КонецЕсли;
	КонецЦикла;
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "НастройкаОбменСБанками";
	ОписаниеПрофиля.Идентификатор = "7737b1b7-f1e6-4117-b088-10800a0caa76";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Настройка 1С:ДиректБанк'");
	ОписаниеПрофиля.Описание =
		НСтр("ru = 'Добавление и изменение настроек обмена с банками.'");
	
	// Использование 1С:Предприятия.
	ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
	ОписаниеПрофиля.Роли.Добавить("ЗапускТолстогоКлиента");
	ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
	ОписаниеПрофиля.Роли.Добавить("ВыводНаПринтерФайлБуферОбмена");
	ОписаниеПрофиля.Роли.Добавить("СохранениеДанныхПользователя");
	
	// Использование программы.
	ОписаниеПрофиля.Роли.Добавить("БазовыеПрава");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБТС");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваИПП");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваЭД");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваКЭДО");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрОписанияИзмененийПрограммы");
	ОписаниеПрофиля.Роли.Добавить("РедактированиеПечатныхФорм");
	
	// Типовые возможности.
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхОтчетовИОбработок");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрСвязанныеДокументы");
	
	// Использование НСИ.
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеНСИ");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеБанков");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеКурсовВалют");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрОтчетаДосьеКонтрагента");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеАдресныхСведений");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеНоменклатурыПоставщиков");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеСертификатовВХранилище");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеЭлектронныхПодписейИШифрование");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДополнительныхРеквизитовИСведений");
	
	// Основные возможности профиля.
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеПапокИФайлов");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеНастроекЭлектронногоВзаимодействия");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеМаршрутовПодписания");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеНастроекОбменСБанками");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеОбменСБанками");
		
	// Использование онлайн-поддержки
	ОписаниеПрофиля.Роли.Добавить("ВызовОнлайнПоддержки");
	ОписаниеПрофиля.Роли.Добавить("ПодключениеКСервисуИнтернетПоддержки");
	ОписаниеПрофиля.Роли.Добавить("ПодключениеСервисовСопровождения");
	
	// Виды ограничения доступа профиля.
	ОписаниеПрофиля.ВидыДоступа.Добавить("ДополнительныеСведения", "ВначалеВсеРазрешены");
	
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
КонецПроцедуры

Процедура ПриЗаполненииПоставляемыхПрофилейГруппДоступаБизнесСеть(ОписанияПрофилей, ПараметрыОбновления)
	
	// БизнесСеть.
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("ЭлектронноеВзаимодействие.БизнесСеть") Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоБизнесСетьБезЧтенияНастроек";
	ОписаниеПрофиля.Идентификатор = "e681ecf3-24f0-4095-affd-110a4d402895";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Обмен документами в 1С:Бизнес-сеть (без чтения настроек)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ВыполнениеОбменаДокументамиБизнесСеть.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоБизнесСетьСЧтениемНастроек";
	ОписаниеПрофиля.Идентификатор = "05021297-056d-451b-9dc3-d2cd44396b97";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Обмен документами в 1С:Бизнес-сеть (с чтением настроек)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ВыполнениеОбменаДокументамиБизнесСеть.Имя);
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ЧтениеНастроекБизнесСеть.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоБизнесСетьСИзменениемНастроек";
	ОписаниеПрофиля.Идентификатор = "7ce36d08-8917-472f-acfb-28efa6639d35";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Обмен документами в 1С:Бизнес-сеть (с изменением настроек)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ВыполнениеОбменаДокументамиБизнесСеть.Имя);
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ДобавлениеИзменениеНастроекБизнесСеть.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоБизнесСетьИзменениеНастроек";
	ОписаниеПрофиля.Идентификатор = "96ec7f7e-ecf9-4bc0-82b6-ebf0601f7958";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Изменение настроек в 1С:Бизнес-сеть (без обмена документами)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ДобавлениеИзменениеНастроекБизнесСеть.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	// Торговые предложения.
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ТорговыеПредложения") Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоТорговыеПредложенияБезЧтенияНастроек";
	ОписаниеПрофиля.Идентификатор = "8c2f6932-4f93-4512-b5ff-63298f261716";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Торговых предложений (без чтения настроек)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ПоискТорговыхПредложенийБизнесСеть.Имя);
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ЧтениеНастроекБизнесСеть.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоТорговыеПредложенияСЧтениемНастроек";
	ОписаниеПрофиля.Идентификатор = "9fcc709b-138c-4302-b7f2-44bf4676e785";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Торговые предложения (с чтением настроек)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ПоискТорговыхПредложенийБизнесСеть.Имя);
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ЧтениеТорговыхПредложенийБизнесСеть.Имя);
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ЧтениеНастроекБизнесСеть.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоТорговыеПредложенияСИзменениемНастроек";
	ОписаниеПрофиля.Идентификатор = "7bb5b67d-2ff3-486e-b558-d725fc027a77";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Торговые предложения (с изменением настроек)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ПоискТорговыхПредложенийБизнесСеть.Имя);
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ДобавлениеИзменениеТорговыхПредложенийБизнесСеть.Имя);
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ЧтениеНастроекБизнесСеть.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоТорговыеПредложенияИзменениеНастроек";
	ОписаниеПрофиля.Идентификатор = "cc68598b-2cf8-43dc-ad56-673bd99584cb";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Изменение настроек торговых предложений (без поиска)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ДобавлениеИзменениеТорговыхПредложенийБизнесСеть.Имя);
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ЧтениеНастроекБизнесСеть.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
КонецПроцедуры

Процедура ПриЗаполненииПоставляемыхПрофилейГруппДоступаИнтеграцияСЯндексКассой(ОписанияПрофилей, ПараметрыОбновления)
	
	// ИнтеграцияСЯндексКассой.
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ИнтеграцияСЯндексКассой") Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоИнтеграцияСЯндексКассойДобавлениеИзменениеОбменов";
	ОписаниеПрофиля.Идентификатор = "98fc8458-db9c-4677-9ced-f8ba9a3c5572";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Интеграция с Яндекс.Кассой (изменение настроек)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ДобавлениеИзменениеОбменовСЯндексКассой.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоИнтеграцияСЯндексКассойПолучениеПлатежнойСсылки";
	ОписаниеПрофиля.Идентификатор = "de734761-fd0e-4533-aee4-bdae371c0998";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Интеграция с Яндекс.Кассой (подготовка платежной ссылки)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ПолучениеПлатежнойСсылкиДляЯндексКассы.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "_ДемоИнтеграцияСЯндексКассойЧтениеОбменов";
	ОписаниеПрофиля.Идентификатор = "7661cdee-fa20-4ff1-a736-95d643f92103";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Демо: Интеграция с Яндекс.Кассой (чтение настроек)'");
	ОписаниеПрофиля.Описание      = НСтр("ru = 'Демонстрационный профиль'");
	ОписаниеПрофиля.Роли.Добавить(Метаданные.Роли.ЧтениеОбменовСЯндексКассой.Имя);
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
КонецПроцедуры

// _Демо конец примера


