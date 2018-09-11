#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ТипЗначенияДанныеЗаполнения = ТипЗнч(ДанныеЗаполнения);
	
	Если ОбщегоНазначения.ЭтоСсылка(ТипЗначенияДанныеЗаполнения) Тогда
		ОснованиеСсылка = ДанныеЗаполнения;
		
		ТребуетсяПодтверждение = Истина;
		ТипДокумента = Перечисления.ТипыЭД.Прочее;
		Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЭлектронныйДокументВходящий") 
			ИЛИ ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЭлектронныйДокументИсходящий") Тогда
			СтруктураРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДанныеЗаполнения,
			"Контрагент, Организация, ДоговорКонтрагента, ТипДокумента, ТребуетсяПодтверждение");
			ТипДокумента			= СтруктураРеквизитов.ТипДокумента;
			ТребуетсяПодтверждение	= СтруктураРеквизитов.ТребуетсяПодтверждение;
			Контрагент				= СтруктураРеквизитов.Контрагент;
			Организация				= СтруктураРеквизитов.Организация;
			ДоговорКонтрагента		= СтруктураРеквизитов.ДоговорКонтрагента;
		Иначе
			Если СтрНайти(ДанныеЗаполнения.Метаданные().ПолноеИмя(), "ПрисоединенныеФайлы") > 0 Тогда
				ОснованиеСсылка = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДанныеЗаполнения, "ВладелецФайла");
				ПоместитьВложениеВоВременноеХранилище(ДанныеЗаполнения, ОснованиеСсылка);
			Иначе
				ОснованиеСсылка = ДанныеЗаполнения;
			КонецЕсли;
			СтруктураРеквизитов = ОбменСКонтрагентамиСлужебный.ЗаполнитьПараметрыЭДПоИсточнику(ОснованиеСсылка);
			Если ТипЗнч(СтруктураРеквизитов) = Тип("Структура") Тогда
				Если ЗначениеЗаполнено(СтруктураРеквизитов.Контрагент) И Контрагент <> СтруктураРеквизитов.Контрагент Тогда
					Контрагент = СтруктураРеквизитов.Контрагент;
				КонецЕсли;
				Если ЗначениеЗаполнено(СтруктураРеквизитов.Организация) И Организация <> СтруктураРеквизитов.Организация Тогда
					Организация = СтруктураРеквизитов.Организация;
				КонецЕсли;
				Если ЗначениеЗаполнено(СтруктураРеквизитов.ДоговорКонтрагента) И ДоговорКонтрагента <> СтруктураРеквизитов.ДоговорКонтрагента Тогда
					ДоговорКонтрагента = СтруктураРеквизитов.ДоговорКонтрагента;
				КонецЕсли;
			КонецЕсли;
			Если ДанныеЗаполнения.Метаданные().Имя = "СоглашенияОбИспользованииЭД" Тогда
				ТипДокумента = Перечисления.ТипыЭД.СоглашениеОбЭДО;
			КонецЕсли;
		КонецЕсли;
		
		ТаблицаИдентификаторов = Новый ТаблицаЗначений;
		Если Метаданные.Документы.Содержит(ОснованиеСсылка.Метаданные()) Тогда
			// Т.к. документом-основанием может быть документ ИБ, сформированный на основании входящего ЭД,
			// то чтобы на стороне получателя данный документ правильно определил основание, в качестве
			// идентификатора передается НомерЭД (всегда является идентификатором документа ИБ, на основании
			// которого формируется ЭДО).
			Запрос = Новый Запрос;
			Запрос.Текст =
			"ВЫБРАТЬ
			|	ЭлектронныйДокументВходящий.Ссылка КАК СообщениеОбмена
			|ПОМЕСТИТЬ втВладельцы
			|ИЗ
			|	Документ.ЭлектронныйДокументВходящий КАК ЭлектронныйДокументВходящий
			|ГДЕ
			|	ЭлектронныйДокументВходящий.Ссылка = &ДокументОснование
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|ВЫБРАТЬ
			|	ЭлектронныйДокументИсходящий.Ссылка
			|ИЗ
			|	Документ.ЭлектронныйДокументИсходящий КАК ЭлектронныйДокументИсходящий
			|ГДЕ
			|	ЭлектронныйДокументИсходящий.Ссылка = &ДокументОснование
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|ВЫБРАТЬ
			|	ЭлектронныйДокументИсходящийДокументыОснования.Ссылка
			|ИЗ
			|	Документ.ЭлектронныйДокументИсходящий.ДокументыОснования КАК ЭлектронныйДокументИсходящийДокументыОснования
			|ГДЕ
			|	ЭлектронныйДокументИсходящийДокументыОснования.ДокументОснование = &ДокументОснование
			|	И НЕ ЭлектронныйДокументИсходящийДокументыОснования.Ссылка.ВидЭД = ЗНАЧЕНИЕ(Перечисление.ВидыЭД.ПроизвольныйЭД)
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|ВЫБРАТЬ
			|	ЭлектронныйДокументВходящийДокументыОснования.Ссылка
			|ИЗ
			|	Документ.ЭлектронныйДокументВходящий.ДокументыОснования КАК ЭлектронныйДокументВходящийДокументыОснования
			|ГДЕ
			|	ЭлектронныйДокументВходящийДокументыОснования.ДокументОснование = &ДокументОснование
			|	И НЕ ЭлектронныйДокументВходящийДокументыОснования.Ссылка.ВидЭД = ЗНАЧЕНИЕ(Перечисление.ВидыЭД.ПроизвольныйЭД)
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	ЭДПрисоединенныеФайлы.НомерЭД КАК ИдентификаторДокументаОснования,
			|	ЭДПрисоединенныеФайлы.УникальныйИД КАК ИдентификаторЭДДокументаОснования
			|ИЗ
			|	втВладельцы КАК втВладельцы
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЭДПрисоединенныеФайлы КАК ЭДПрисоединенныеФайлы
			|		ПО втВладельцы.СообщениеОбмена = ЭДПрисоединенныеФайлы.ВладелецФайла
			|			И (ЭДПрисоединенныеФайлы.ТипЭлементаВерсииЭД = ЗНАЧЕНИЕ(Перечисление.ТипыЭлементовВерсииЭД.ПервичныйЭД))
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|ВЫБРАТЬ
			|	ЭДПрисоединенныеФайлы.НомерЭД,
			|	ЭДПрисоединенныеФайлы.УникальныйИД
			|ИЗ
			|	втВладельцы КАК втВладельцы
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ЭДПрисоединенныеФайлы КАК ЭДПрисоединенныеФайлы
			|		ПО втВладельцы.СообщениеОбмена = ЭДПрисоединенныеФайлы.ВладелецФайла
			|			И (ЭДПрисоединенныеФайлы.ТипЭлементаВерсииЭД = ЗНАЧЕНИЕ(Перечисление.ТипыЭлементовВерсииЭД.ЭСФ))";
			
			Запрос.УстановитьПараметр("ДокументОснование", ОснованиеСсылка);
			ТаблицаИдентификаторов = Запрос.Выполнить().Выгрузить();
			Если ТаблицаИдентификаторов.Количество() = 0 Тогда
				СтрокаИдентификатора = ТаблицаИдентификаторов.Добавить();
				СтрокаИдентификатора.ИдентификаторДокументаОснования = Строка(ОснованиеСсылка.УникальныйИдентификатор());
				СтрокаИдентификатора.ИдентификаторЭДДокументаОснования = Строка(ОснованиеСсылка.УникальныйИдентификатор());
			КонецЕсли;
			
			ИдентификаторыОснованийВладельцаФайла.Загрузить(ТаблицаИдентификаторов);
			
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Ответственный = Справочники.Пользователи.ПустаяСсылка();
	
	ПрофильНастроекЭДО = Неопределено;
	НастройкаЭДО       = Неопределено;
	СостояниеЭДО       = Неопределено;
	ДатаИзмененияСостоянияЭДО = Дата(1,1,1);
	ДатаДокументаОтправителя  = Дата(1,1,1);
	НомерДокументаОтправителя = "";
	ПричинаОтклонения = "";
	УникальныйИД = "";
	Прочитан = Ложь;
	
	СписокПодписантов.Очистить();
	
КонецПроцедуры

Процедура ПоместитьВложениеВоВременноеХранилище(ПрисоединенныйФайлСсылка, ВладелецФайла)
	
	СтруктураФайла = РаботаСФайлами.ДанныеФайла(ПрисоединенныйФайлСсылка, Новый УникальныйИдентификатор);
	СтруктураФайла.Вставить("ОтносительныйПуть", "");
	АдресХранилища = ПоместитьВоВременноеХранилище(СтруктураФайла, Новый УникальныйИдентификатор);
	ОбменСКонтрагентамиСлужебный.ПоместитьПараметрВПараметрыКлиентаНаСервере(ВладелецФайла, АдресХранилища);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если ЭтотОбъект.ЭтоНовый() Тогда
				
		Если ЭтотОбъект.ВидЭД = Перечисления.ВидыЭД.ПроизвольныйЭД Тогда
			
			Если ПустаяСтрока(ЭтотОбъект.Номер) Тогда
				УстановитьНовыйНомер();
			КонецЕсли;
			НомерДокументаОтправителя = ЭтотОбъект.Номер;
			ДатаДокументаОтправителя = ЭтотОбъект.Дата;
			НаименованиеДокументаОтправителя = ЭтотОбъект.ТипДокумента;
		КонецЕсли;
		
	КонецЕсли;
	
	ЗаполнитьОтветственного();
	
	Если ОбменДанными.Загрузка Тогда 
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьОтветственного()
	
	Если Не ЗначениеЗаполнено(Ответственный) Тогда
		ОтветственныйПоЭД = Неопределено;
		ОбменСКонтрагентамиПереопределяемый.ПолучитьОтветственногоПоЭД(Контрагент, НастройкаЭДО, ОтветственныйПоЭД);
		Ответственный = ?(ЗначениеЗаполнено(ОтветственныйПоЭД), ОтветственныйПоЭД, Пользователи.ТекущийПользователь());
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли