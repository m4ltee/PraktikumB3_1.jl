"""
Die Funktion divide_jl ist eine julia Implementierung von divide.py.
Diese Funktion arbeitet nicht mit .txt Dateien sondern mit arrays.

### Argumente
- `data::Array`: enthält die Messzeiten (erster Parameter)
- `Δt::Real`: Länge der Intervalle in s (zweiter Parameter)

### Rückgabewert
- `counts::Array`: enthält Anzahl der Signale für jedes Interval

### Beispiel
```julia
counts = divide_jl(data, 10)
```
"""
function divide_jl(data::Array, Δt::Real)
    counts = []
    for x in data
        i = round(Int, x/Δt, RoundDown)
        while length(counts) <= i
            append!(counts, 0)
        end
        counts[i+1] += 1
    end
    pop!(counts)
    return counts
end
"""
Die Funktion binomial_jl ist eine julia Implementierung von binomial.py.
Diese Funktion arbeitet nicht mit .txt Dateien sondern mit arrays.

### Argumente
- `data::Array`: enthält die Messzeiten (erster Parameter)
- `Δt::Real`: Länge der Intervalle in s (zweiter Parameter)
- `n::Int`: Binningparameter (dritter Parameter)

### Rückgabewert
- `x::Array`: enthält die x-Werte der Binomialverteilung
- `y::Array`: enthält die y-Werte der Binomialverteilung

### Beispiel


```julia
x, y = binomial_jl(data, 0.2, 1)
```
"""
function binomial_jl(data::Array, Δt::Real, n::Int)
    counts = divide_jl(data, Δt)
    hist1 = []
    for i in 1:length(counts)
        while length(hist1) < counts[i]+1
            append!(hist1, 0)
        end
        hist1[counts[i]+1] += 1
    end

    hist2 = []
    for i in 1:length(hist1)
        j = round(Int, (i-1)/n, RoundDown)
        while length(hist2) <= j
            append!(hist2, 0)
        end
        hist2[j+1] += hist1[i]
    end

    return [i for i in 0:length(hist2)-1], hist2
end
"""
Die Funktion interval_jl ist eine julia Implementierung von interval.py.
Diese Funktion arbeitet nicht mit .txt Dateien sondern mit arrays.

### Argumente
- `data::Array`: enthält die Messzeiten (erster Parameter)
- `Δt::Real`: Länge der Intervalle in s (zweiter Parameter)
- `n::Int`: Binningparameter (dritter Parameter)

### Rückgabewert
- `x::Array`: enthält die x-Werte der Intervallverteilung
- `y::Array`: enthält die y-Werte der Intervallverteilung

### Beispiel


```julia
x, y = interval_jl(data, 0.001, 1)
```
"""
function interval_jl(data::Array, Δt::Real, n::Int)
    hist = []
    for i in 1:length(data)-n
        t = data[i+n]-data[i]
        k = round(Int, t/Δt, RoundDown)
        while length(hist) <= k
            append!(hist, 0)
        end
        hist[k+1] += 1
    end
    return [i for i in 0:length(hist)-1], hist
end
