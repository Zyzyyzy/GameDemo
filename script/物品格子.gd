extends Control


# ====================================== 这个函数要放在要 放置物品的格子中
#1.是否能将物品放在这里
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
		#1.可以放置
		return true 
		#2.不可放置
		#return false 
		
#2.放置物品的操作
func _drop_data(at_position: Vector2, data: Variant) -> void:
	# data即为物品，将物品从原来的父节点移除，加入到物品格子节点中
	data.get_parent().remove_child(data)
	add_child(data)

# ====================================== 这个函数要放在你要拖放的物品本身的脚本中
# 1.物品本身的属性，能否被拖拽
func _get_drag_data(at_position: Vector2) -> Variant:
	var data = self  # 1.将拖拽的数据设置为物品节点自身
	var prev = TextureRect.new() # 2.新建一个图片节点，用来当做拖拽物品的预览图
	prev.texture = self.texture # 2.将预览图设置为当前物品自身的贴图
	set_drag_preview(prev) # 3.设置预览
	return data # 4.返回数据，等待其他可以放置物品的节点接收被拖拽的物品 [此处即为道具a]


