////////////////////////////////////////////////////////////////////////////////
// ДополнительныеВнешниеКомпоненты: Механизм для работы с внешними компонентами.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ПоставляемыеДанные

// Зарегистрировать обработчики поставляемых данных
//
// При получении уведомления о доступности новых общих данных, вызывается процедуры
// ДоступныНовыеДанные модулей, зарегистрированных через ПолучитьОбработчикиПоставляемыхДанных.
// В процедуру передается Дескриптор - ОбъектXDTO Descriptor.
// 
// В случае, если ДоступныНовыеДанные устанавливает аргумент Загружать в значение Истина, 
// данные загружаются, дескриптор и путь к файлу с данными передаются в процедуру 
// ОбработатьНовыеДанные. Файл будет автоматически удален после завершения процедуры.
// Если в менеджере сервиса не был указан файл - значение аргумента равно Неопределено.
//
// Параметры: 
//   Обработчики - ТаблицаЗначений - таблица для добавления обработчиков. 
//       Колонки:
//        ВидДанных, строка - код вида данных, обрабатываемый обработчиком
//        КодОбработчика, строка(20) - будет использоваться при восстановлении обработки данных после сбоя
//        Обработчик,  ОбщийМодуль - модуль, содержащий следующие процедуры:
//          ДоступныНовыеДанные(Дескриптор, Загружать) Экспорт  
//          ОбработатьНовыеДанные(Дескриптор, ПутьКФайлу) Экспорт
//          ОбработкаДанныхОтменена(Дескриптор) Экспорт
//
Процедура ЗарегистрироватьОбработчикиПоставляемыхДанных(Знач Обработчики) Экспорт
	
	МодульВнешниеКомпоненты = ОбщегоНазначения.ОбщийМодуль("ДополнительныеВнешниеКомпоненты");
	
	Обработчик = Обработчики.Добавить();
	Обработчик.ВидДанных = "ExtComp";
	Обработчик.КодОбработчика = "ExtComp";
	Обработчик.Обработчик = МодульВнешниеКомпоненты;
	
КонецПроцедуры

// Вызывается при получении уведомления о новых данных.
// В теле следует проверить, необходимы ли эти данные приложению, 
// и если да - установить флажок Загружать.
// 
// Параметры:
//   Дескриптор - ОбъектXDTO - Descriptor.
//   Загружать  - Булево - возвращаемое значение.
//
Процедура ДоступныНовыеДанные(Знач Дескриптор, Загружать) Экспорт
	
	// Загрузка внешних компонент.
	Если Дескриптор.DataType = "ExtComp" Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		               |	1 КАК Поле1
		               |ИЗ
		               |	Справочник.ДополнительныеВнешниеКомпоненты КАК ВнешниеКомпоненты
		               |ГДЕ
		               |	ВнешниеКомпоненты.Идентификатор = &Идентификатор
		               |	И ВнешниеКомпоненты.Версия = &Версия";
		Запрос.УстановитьПараметр("Идентификатор", Дескриптор.Properties.Property.Получить(0).Value);
		Запрос.УстановитьПараметр("Версия", Дескриптор.Properties.Property.Получить(1).Value);
		
		Загружать = Запрос.Выполнить().Пустой();
		
	КонецЕсли;
	
КонецПроцедуры

// Вызывается после вызова ДоступныНовыеДанные, позволяет разобрать данные.
//
// Параметры:
//   Дескриптор - ОбъектXDTO - Дескриптор.
//   ПутьКФайлу - Строка - Полное имя извлеченного файла. Файл будет автоматически удален после завершения процедуры.
//
Процедура ОбработатьНовыеДанные(Знач Дескриптор, Знач ПутьКФайлу) Экспорт
	
	Если Дескриптор.DataType = "ExtComp" Тогда
		
		Данные = Новый ДвоичныеДанные(ПутьКФайлу);
		
		Адрес = ПоместитьВоВременноеХранилище(Данные);
		
		Справочники.ДополнительныеВнешниеКомпоненты.СохранитьВнешнююКомпонентуВИнформационнойБазе(Адрес);
		
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при отмене обработки данных в случае сбоя
// 
// Параметры:
//  Дескриптор - ОбъектXDTO - Дескриптор.
//
Процедура ОбработкаДанныхОтменена(Знач Дескриптор) Экспорт
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
