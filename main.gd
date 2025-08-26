@tool
extends Node2D

func _ready() -> void:
    var icon: Texture2D = load("res://icon.svg")
    var img := Image.create_empty(12, 64, false, Image.FORMAT_RGBA8)
    img.fill(Color(0, 0.5, 0))

    RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(50, 10))

    img.fill(Color(0.7, 0, 0))
    RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(10, 0), 0, 1, 0)
