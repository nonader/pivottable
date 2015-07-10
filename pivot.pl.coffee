callWithJQuery = (pivotModule) ->
    if typeof exports is "object" and typeof module is "object" # CommonJS
        pivotModule require("jquery")
    else if typeof define is "function" and define.amd # AMD
        define ["jquery"], pivotModule
    # Plain browser env
    else
        pivotModule jQuery
        
callWithJQuery ($) ->
    nf = $.pivotUtilities.numberFormat
    tpl = $.pivotUtilities.aggregatorTemplates

    frFmt =    nf(thousandsSep: " ", decimalSep: ",")
    frFmtInt = nf(digitsAfterDecimal: 0, thousandsSep: " ", decimalSep: ",")
    frFmtPct = nf(digitsAfterDecimal: 1, scaler: 100, suffix: "%", thousandsSep: " ", decimalSep: ",")

    $.pivotUtilities.locales.pl = 
        localeStrings:
            renderError: "Wystąpił błąd renderowania wyniki tabeli przestawnej.",
            computeError: "Wystąpił błąd obliczania wyników tabeli przestawnej.",
            uiRenderError:  "Wystąpił błąd renderowania tabeli przestawnej."
            selectAll: "Wszystkie"
            selectNone: "Brak zaznaczenia"
            tooMany: "(za dużo elementów do wyświetlenia)"
            filterResults: "Filtruj wyniki"
            totals: "Razem"
            vs: "na"
            by: "po"

        aggregators: 
            "Ilość":                              tpl.count(frFmtInt)
            "Zlicz unikalne wartości":            tpl.countUnique(frFmtInt)
            "Lista unikalnych wartości":          tpl.listUnique(", ")
            "Suma":                               tpl.sum(frFmt)
            "Suma całkowita":                     tpl.sum(frFmtInt)
            "Średnia":                            tpl.average(frFmt)
            "Minimum":                            tpl.min(frFmt)
            "Maksimum":                           tpl.max(frFmt)
            "Suma nad sumę":                      tpl.sumOverSum(frFmt)
            "80% górnej granicy":                 tpl.sumOverSumBound80(true, frFmt)
            "80% dolnej ganicy":                  tpl.sumOverSumBound80(false, frFmt)
            "Suma jako procent ogólnej":          tpl.fractionOf(tpl.sum(),   "total", frFmtPct)
            "Suma jako ułamek krotek":            tpl.fractionOf(tpl.sum(),   "row",   frFmtPct)
            "Suma jako ułamek kolumn":            tpl.fractionOf(tpl.sum(),   "col",   frFmtPct)
            "Liczba jako procent ogólnej":        tpl.fractionOf(tpl.count(), "total", frFmtPct)
            "Liczba jako procent krotek":         tpl.fractionOf(tpl.count(), "row",   frFmtPct)
            "Liczba jako procent kolumn":         tpl.fractionOf(tpl.count(), "col",   frFmtPct)

        renderers:
            "Table":                           $.pivotUtilities.renderers["Table"]
            "Tabela z wykresem słupkowym":     $.pivotUtilities.renderers["Table Barchart"]
            "Mapa termiczna":                  $.pivotUtilities.renderers["Heatmap"]
            "Mapa termiczna wierszy":          $.pivotUtilities.renderers["Row Heatmap"]
            "Mapa termiczna kolumn":           $.pivotUtilities.renderers["Col Heatmap"]


