#Область СлужебныйПрограммныйИнтерфейс

#Область КлассификаторВалют

// Возвращает данные валюты по коду ОКВ.
//
// Параметры:
//  КодВалюты	 - Строка - код валюты согласно ОКВ.
// 
// Возвращаемое значение:
//  Структура - имеет ключи:
//    * КодВалютыЦифровой - цифровой код по классификатору.
//    * КодВалютыБуквенный - буквенный код по классификатору.
//    * Наименование - наименование по классификатору.
//
Функция ДанныеВалютыПоКлассификатору(КодВалюты) Экспорт

	Результат = Неопределено;
	
	ДанныеКлассификатора = ОбменСКонтрагентамиСлужебный.ДанныеКлассификатораВалют();
	Если ДанныеКлассификатора <> Неопределено И ДанныеКлассификатора.Количество() Тогда
		СтрокаВалюты = ДанныеКлассификатора.Найти(КодВалюты, "КодВалютыЦифровой");
		
		Если СтрокаВалюты <> Неопределено Тогда
			Результат = Новый Структура("КодВалютыЦифровой, КодВалютыБуквенный, Наименование");
			ЗаполнитьЗначенияСвойств(Результат, СтрокаВалюты);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;

КонецФункции 

#КонецОбласти

#Область КлассификаторСтранМира

// см. УправлениеКонтактнойИнформацией.ДанныеКлассификатораСтранМираПоКоду.
Функция ДанныеКлассификатораСтранМираПоКоду(Знач Код, Знач ТипКода = "КодСтраны") Экспорт

	Возврат УправлениеКонтактнойИнформацией.ДанныеКлассификатораСтранМираПоКоду(Код, ТипКода);

КонецФункции 

#КонецОбласти

#КонецОбласти

