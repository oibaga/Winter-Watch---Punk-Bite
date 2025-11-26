class_name Anomaly extends Node3D

@export var roomPresset : RoomPresset 
@export var type : AnomalyTypes = AnomalyTypes.CreatureType

enum AnomalyTypes {CreatureType, SoundType, VisualType, GlitchType, GeigerType, CopyType}
