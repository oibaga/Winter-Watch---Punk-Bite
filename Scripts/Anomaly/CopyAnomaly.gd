extends Anomaly

func SpawnAnomaly():
	super.SpawnAnomaly()
	visible = true

func ResolveAnomaly():
	super.ResolveAnomaly()
	visible = false
