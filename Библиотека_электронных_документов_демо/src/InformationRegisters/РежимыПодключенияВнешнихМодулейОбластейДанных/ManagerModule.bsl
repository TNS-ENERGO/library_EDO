#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

Функция РежимИсполненияВнешнегоМодуля(Знач ТипПрограммногоМодуля, Знач ИдентификаторПрограммногоМодуля) Экспорт
	
	Менеджер = СоздатьМенеджерЗаписи();
	Менеджер.ТипПрограммногоМодуля = ТипПрограммногоМодуля;
	Менеджер.ИдентификаторПрограммногоМодуля = ИдентификаторПрограммногоМодуля;
	Менеджер.Прочитать();
	Если Менеджер.Выбран() Тогда
		
		Возврат Менеджер.БезопасныйРежим;
		
	Иначе
		
		Возврат Неопределено;
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецЕсли