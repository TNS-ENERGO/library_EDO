
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПоказатьПредупреждение(,
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Время сеанса: %1
				|На сервере: %2
				|На клиенте: %3
				|
				|Время сеанса - это время сервера,
				|приведенное к часовому поясу клиента.'"),
			Формат(ОбщегоНазначенияКлиент.ДатаСеанса(), "ДЛФ=T"),
			Формат(ДатаСервера(), "ДЛФ=T"),
			Формат(ТекущаяДата(), "ДЛФ=T")));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ДатаСервера()
	
	Возврат ТекущаяДата();
	
КонецФункции

#КонецОбласти