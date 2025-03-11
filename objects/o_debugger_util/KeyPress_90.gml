isoProjection = !isoProjection

o_zoom_manager.debugChangeProjection(isoProjection)


with (o_iso_renderer) {
    instance_destroy(id)
}

instance_create_layer(0, 0, "Managers", o_iso_renderer)