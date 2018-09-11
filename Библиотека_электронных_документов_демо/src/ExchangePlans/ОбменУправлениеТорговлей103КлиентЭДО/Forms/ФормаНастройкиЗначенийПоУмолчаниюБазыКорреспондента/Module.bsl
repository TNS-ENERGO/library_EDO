
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДополнительныеДанные = Неопределено;
	
	ОбменДаннымиСервер.ФормаНастройкиЗначенийПоУмолчаниюБазыКорреспондентаПриСозданииНаСервере(
		ЭтотОбъект, Метаданные.ПланыОбмена.ОбменУправлениеПредприятиемКлиентЭДО.Имя, ДополнительныеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ОбменДаннымиКлиент.ФормаНастройкиПередЗакрытием(Отказ, ЭтотОбъект, ЗавершениеРаботы);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	ОбменДаннымиСервер.ОпределитьПроверяемыеРеквизитыСУчетомНастроекВидимостиПолейФормы(ПроверяемыеРеквизиты, Элементы);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	ОбменДаннымиКлиент.ОбработчикВыбораЭлементовБазыКорреспондентаОбработкаВыбора(ЭтотОбъект, ВыбранноеЗначение);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СкладНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ПараметрыВыбора = Новый Структура("ВыборГруппИЭлементов", Элемент.ВыборГруппИЭлементов);
	
	ОбменДаннымиКлиент.ОбработчикВыбораЭлементовБазыКорреспондентаНачалоВыбора("Склад", "Справочник.Склады", 
		ЭтотОбъект, СтандартнаяОбработка, ПараметрыВнешнегоСоединения, ПараметрыВыбора);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийКоманд

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ОбменДаннымиКлиент.ФормаНастройкиЗначенийПоУмолчаниюКомандаЗакрытьФорму(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

