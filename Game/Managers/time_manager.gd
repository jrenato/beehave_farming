extends Node

var ra = [0.661133,-0.450579,-0.102644,0.003019,-0.017206,-0.010087]
var rb = [-0.228901,-0.139233,0.029436,0.047411,0.007989]
var ga = [0.626849,-0.437814,-0.050352,-0.009737,-0.028222,0.002317]
var gb = [-0.279056,-0.106992,0.066646,0.032230,-0.001321]
var ba = [0.725802,-0.268970,-0.035903,-0.006988,-0.021679,-0.002546]
var bb = [-0.175541,-0.079950,0.034039,0.021785,-0.000069]
var w = [0.258071,0.264981,0.258893]

var hour: float = 7.0
var time_speed: float = 2.0


func _process(delta: float) -> void:
	hour = clampf(hour + delta * time_speed, 0, 24)
	if hour == 24:
		hour = 0


func get_day_night_cycle_color() -> Color:
	var r: float = 0
	var g: float = 0
	var b: float = 0
	var time: float = TimeManager.hour

	for i in range(6):
		r += ra[i]*cos(i*time*w[0])
		g += ga[i]*cos(i*time*w[1])
		b += ba[i]*cos(i*time*w[2])

	for i in range(1,6):
		r += rb[i-1]*sin(i*time*w[0])
		g += gb[i-1]*sin(i*time*w[1])
		b += bb[i-1]*sin(i*time*w[2])

	r = min(r,1)
	g = min(g,1)
	b = min(b,1)

	return Color(r,g,b,1)


func is_day() -> bool:
	if hour >= 6 and hour <= 20:
		return true

	return false
