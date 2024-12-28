extends TileMapLayer
class_name GroundTiles

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for tile in get_children():
		tile.add_to_group("Ground Tiles")
