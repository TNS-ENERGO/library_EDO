#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПолучениеФайловИзИнтернета") Тогда
		МодульПолучениеФайловИзИнтернетаКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПолучениеФайловИзИнтернетаКлиент");
		МодульПолучениеФайловИзИнтернетаКлиент.ОткрытьФормуПараметровПроксиСервера();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти