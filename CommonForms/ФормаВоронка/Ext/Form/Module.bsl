
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	РезультатЗапроса = ОбщегоНазначенияСервер.ПолучитьКарточкиУчебнойКоллекции();
	ЭтаФорма.ДоступныеЭлементы.Загрузить( РезультатЗапроса.Выгрузить() );
	
	ЭтаФорма.ИндексТекущегоЭлемента = 0;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЭтаФорма.ДоступныеЭлементы.Количество() Тогда	
		ОтобразитьТекущийЭлемент();
	Иначе
		Сообщить("Нет данных!");
		
		ЭтаФорма.Доступность 						= Ложь;
		ЭтаФорма.Элементы.ГруппаКоманды.Доступность = Ложь;		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтобразитьТекущийЭлемент()
	
	Карточка 		= ЭтаФорма.ДоступныеЭлементы.НайтиПоИдентификатору(ИндексТекущегоЭлемента).Ссылка;
	ДанныеКарточки 	= ОбщегоНазначенияСервер.ПолучитьОсновныеДанныеКарточки(Карточка);
	
	ЭтаФорма.Вопрос = ДанныеКарточки.Вопрос;
	ЭтаФорма.Ответ 	= ДанныеКарточки.Ответ;
	
КонецПроцедуры

&НаКлиенте
Процедура Знаю(Команда)
	УстановитьСтатусКарточки(Истина);
КонецПроцедуры

&НаКлиенте
Процедура Сомневаюсь(Команда)
	УстановитьСтатусКарточки(Ложь);
КонецПроцедуры

// Процедура - Установить статус карточки
//
// Параметры:
//  Статус	 - Булево - где Истина это знаю, а Ложь не знаю
//
&НаКлиенте
Процедура УстановитьСтатусКарточки(Статус) 

	ОцененнаяКарточка = ЭтаФорма.ДоступныеЭлементы.НайтиПоИдентификатору(ИндексТекущегоЭлемента).Ссылка;	
	ОбщегоНазначенияСервер.УстановитьСтатусКарточкиНаСервере(ОцененнаяКарточка, Статус);	
	
	ЭтаФорма.ИндексТекущегоЭлемента = ЭтаФорма.ИндексТекущегоЭлемента + 1;
	ВсеЭлементыКоллекцииПоказаны 	= ЭтаФорма.ИндексТекущегоЭлемента >= ЭтаФорма.ДоступныеЭлементы.Количество();
	
	Если ВсеЭлементыКоллекцииПоказаны Тогда		
		
		ЭтаФорма.Вопрос = "";
		ЭтаФорма.Ответ 	= "";
		
		Сообщить("Все элементы коллекции пройдены!");
		Возврат;
		
	КонецЕсли;	

	ОтобразитьТекущийЭлемент();
	
КонецПроцедуры
