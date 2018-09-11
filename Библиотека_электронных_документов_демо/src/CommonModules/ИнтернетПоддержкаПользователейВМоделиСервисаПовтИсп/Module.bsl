////////////////////////////////////////////////////////////////////////////////
// Подсистема "Работа в модели сервиса.Базовая функциональность БИП".
// ОбщийМодуль.ИнтернетПоддержкаПользователейВМоделиСервисаПовтИсп.
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Функция КлючОбластиДанных(ЗначениеРазделителя) Экспорт
	
	МодульРаботаВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");
	МодульРаботаВМоделиСервиса.УстановитьРазделениеСеанса(Истина, ЗначениеРазделителя);
	
	УстановитьПривилегированныйРежим(Истина);
	Результат = Константы.КлючОбластиДанных.Получить();
	УстановитьПривилегированныйРежим(Ложь);
	
	МодульРаботаВМоделиСервиса.УстановитьРазделениеСеанса(Ложь);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти