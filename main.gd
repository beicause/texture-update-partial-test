@tool
extends Node2D

func _ready() -> void:
	update_2d()
	update_2d_compressed()
	update_layered()
	update_3d()

func update_2d():
	var icon: Texture2D = load("res://icon.svg")
	var img := Image.create_empty(12, 64, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0.5, 0))

	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(50, 10))

	var icon_img := icon.get_image();
	if Engine.is_editor_hint():
		icon_img = icon_img.duplicate()
	icon_img.clear_mipmaps(); # Mipmaps must be 1.
	RenderingServer.texture_update_partial(icon.get_rid(), icon_img, Rect2i(Vector2i(0, 0), Vector2i(32, 32)), Vector2i(16, 16), 0, 1, 0)

func update_2d_compressed():
	var icon: Texture2D = load("res://icon_compressed.svg")
	var img := Image.create_empty(12, 64, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0.5, 0, 0.99))
	img.compress(Image.COMPRESS_S3TC, Image.COMPRESS_SOURCE_SRGB)

	if img.get_format() != Image.FORMAT_DXT5 || icon.get_image().get_format() != Image.FORMAT_DXT5:
		var n := ClassDB.class_get_enum_constants("Image", "Format")
		push_error("compressed image format doesn't match, ", n[img.get_format()], " vs ", n[icon.get_image().get_format()])

	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(0, 0), 0, 0)
	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(16, 0), 0, 1)

func update_layered():
	var icon: TextureLayered = load("res://icon_layered.svg")
	var img := Image.create_empty(12, 32, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0.5, 0))

	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(50, 10))
	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(50, 10), 0, 0, 2)

	var icon_img := icon.get_layer_data(0);
	if Engine.is_editor_hint():
		icon_img = icon_img.duplicate()
	icon_img.clear_mipmaps(); # Mipmaps must be 1.
	RenderingServer.texture_update_partial(icon.get_rid(), icon_img, Rect2i(Vector2i(0, 0), Vector2i(16, 16)), Vector2i(16, 16), 0, 1, 3)

func update_3d():
	var icon: Texture3D = load("res://icon_3d.svg")
	var img := Image.create_empty(12, 32, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0.5, 0))

	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(10, 10))
	img.fill(Color(0.5, 0, 0))
	img.resize(12, 16)
	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(0, 0), 1, 0)
	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(0, 0), 1, 1) # Note: In mipmap #1, depth is half of the original depth.
	img.fill(Color(0, 0, 0.5))
	RenderingServer.texture_update_partial(icon.get_rid(), img, Rect2i(Vector2i.ZERO, img.get_size()), Vector2i(30, 10), 2)

	var icon_img: Image = load("res://icon.svg").get_image();
	if Engine.is_editor_hint():
		icon_img = icon_img.duplicate()
	icon_img.clear_mipmaps(); # Mipmaps must be 1.
	RenderingServer.texture_update_partial(icon.get_rid(), icon_img, Rect2i(Vector2i(0, 0), Vector2i(16, 16)), Vector2i(16, 16), 3)
