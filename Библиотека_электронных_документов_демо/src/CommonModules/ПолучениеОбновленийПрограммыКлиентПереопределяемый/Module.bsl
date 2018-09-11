
////////////////////////////////////////////////////////////////////////////////
// Подсистема "Получение обновлений программы".
// ОбщийМодуль.ПолучениеОбновленийПрограммыКлиентПереопределяемый.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определяет необходимость показа всплывающего оповещения о
// доступном обновлении программы. Вызывается только при наличии
// встроенной подсистемы СтандартныеПодсистемы.ТекущиеДела.
//
// Параметры:
//	Использование - Булево - в параметре возвращается признак необходимости
//		показа оповещения. Истина- показать, Ложь - в противном случае.
//		Значение по умолчанию - Ложь.
//
Процедура ПриОпределенииНеобходимостиПоказаОповещенийОДоступныхОбновлениях(Использование) Экспорт
	
	
КонецПроцедуры

#КонецОбласти
