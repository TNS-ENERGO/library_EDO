#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Находит счет-фактуру для заданного документа.
//
// Параметры:
//   Основание - ДокументСсылка - Документ, для которого необходимо найти счет-фактуру.
//
// Возвращаемое значение:
//   ДокументСсылка.СчетФактураВыданный, Неопределено - ссылка на счет-фактуру или неопределено,
//                                                      если объект не найден.
//
Функция СчетФактураДокумента(Основание) Экспорт
	
	СчетФактура = Неопределено;
	
	Если НЕ ЗначениеЗаполнено(Основание) Тогда
		Возврат СчетФактура;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	СчетФактураПолученныйДокументыОснования.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.СчетФактураПолученный.ДокументыОснования КАК СчетФактураПолученныйДокументыОснования
	|ГДЕ
	|	СчетФактураПолученныйДокументыОснования.ДокументОснование = &Основание
	|	И НЕ СчетФактураПолученныйДокументыОснования.Ссылка.ПометкаУдаления";
	Запрос.УстановитьПараметр("Основание", Основание);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		СчетФактура = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат СчетФактура;
	
КонецФункции

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Поля.Добавить("ПредставлениеНомера");
	Поля.Добавить("Дата");
	Поля.Добавить("ВидДокумента");
	Поля.Добавить("ВидОперации");
	
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Представление = КлиентЭДОКлиентСервер.ПредставлениеВходящегоДокумента(Данные);
	
КонецПроцедуры

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	КлиентЭДОВызовСервера.ОбработкаПолученияФормыСчетаФактуры(
		ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти
