package sdl;

abstract VkSurface(hl.Bytes) {
}

abstract VkShaderModule(hl.Abstract<"vk_shader_module">) {
}

abstract VkGraphicsPipeline(hl.Abstract<"vk_gpipeline">) {
}

abstract VkPipelineLayout(hl.Abstract<"vk_pipeline_layout">) {
}

abstract VkRenderPass(hl.Abstract<"vk_render_pass">) {
}

abstract VkDescriptorSetLayout(hl.Abstract<"vk_descriptor_layout">) {
}

abstract VkFramebuffer(hl.Abstract<"vk_framebuffer">) {
}

abstract VkImageView(hl.Abstract<"vk_image_view">) {
}

abstract VkBufferView(hl.Abstract<"vk_buffer_view">) {
}

abstract VkSampler(hl.Abstract<"vk_sampler">) {
}

abstract VkBuffer(hl.Abstract<"vk_buffer">) {
}

abstract VkDeviceMemory(hl.Abstract<"vk_device_memory">) {
}

abstract VkDescriptorPool(hl.Abstract<"vk_descriptor_pool">) {
}

abstract VkDescriptorSet(hl.Abstract<"vk_descriptor_set">) {
}

enum abstract VkStructureType(Int) {
	var APPLICATION_INFO = 0;
	var INSTANCE_CREATE_INFO = 1;
	var DEVICE_QUEUE_CREATE_INFO = 2;
	var DEVICE_CREATE_INFO = 3;
	var SUBMIT_INFO = 4;
	var MEMORY_ALLOCATE_INFO = 5;
	var MAPPED_MEMORY_RANGE = 6;
	var BIND_SPARSE_INFO = 7;
	var FENCE_CREATE_INFO = 8;
	var SEMAPHORE_CREATE_INFO = 9;
	var EVENT_CREATE_INFO = 10;
	var QUERY_POOL_CREATE_INFO = 11;
	var BUFFER_CREATE_INFO = 12;
	var BUFFER_VIEW_CREATE_INFO = 13;
	var IMAGE_CREATE_INFO = 14;
	var IMAGE_VIEW_CREATE_INFO = 15;
	var SHADER_MODULE_CREATE_INFO = 16;
	var PIPELINE_CACHE_CREATE_INFO = 17;
	var PIPELINE_SHADER_STAGE_CREATE_INFO = 18;
	var PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO = 19;
	var PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO = 20;
	var PIPELINE_TESSELLATION_STATE_CREATE_INFO = 21;
	var PIPELINE_VIEWPORT_STATE_CREATE_INFO = 22;
	var PIPELINE_RASTERIZATION_STATE_CREATE_INFO = 23;
	var PIPELINE_MULTISAMPLE_STATE_CREATE_INFO = 24;
	var PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO = 25;
	var PIPELINE_COLOR_BLEND_STATE_CREATE_INFO = 26;
	var PIPELINE_DYNAMIC_STATE_CREATE_INFO = 27;
	var GRAPHICS_PIPELINE_CREATE_INFO = 28;
	var COMPUTE_PIPELINE_CREATE_INFO = 29;
	var PIPELINE_LAYOUT_CREATE_INFO = 30;
	var SAMPLER_CREATE_INFO = 31;
	var DESCRIPTOR_SET_LAYOUT_CREATE_INFO = 32;
	var DESCRIPTOR_POOL_CREATE_INFO = 33;
	var DESCRIPTOR_SET_ALLOCATE_INFO = 34;
	var WRITE_DESCRIPTOR_SET = 35;
	var COPY_DESCRIPTOR_SET = 36;
	var FRAMEBUFFER_CREATE_INFO = 37;
	var RENDER_PASS_CREATE_INFO = 38;
	var COMMAND_POOL_CREATE_INFO = 39;
	var COMMAND_BUFFER_ALLOCATE_INFO = 40;
	var COMMAND_BUFFER_INHERITANCE_INFO = 41;
	var COMMAND_BUFFER_BEGIN_INFO = 42;
	var RENDER_PASS_BEGIN_INFO = 43;
	var BUFFER_MEMORY_BARRIER = 44;
	var IMAGE_MEMORY_BARRIER = 45;
	var MEMORY_BARRIER = 46;
	var LOADER_INSTANCE_CREATE_INFO = 47;
	var LOADER_DEVICE_CREATE_INFO = 48;
}

enum VkPipelineCreateFlags {
	DISABLE_OPTIMIZATION;
	ALLOW_DERIVATIVES;
	DERIVATIVE;
	VIEW_INDEX_FROM_DEVICE_INDEX;
	DISPATCH_BASE;
	DEFER_COMPILE_NV;
	CAPTURE_STATISTICS_KHR;
	CAPTURE_INTERNAL_REPRESENTATIONS_KHR;
	FAIL_ON_PIPELINE_COMPILE_REQUIRED_EXT;
	EARLY_RETURN_ON_FAILURE_EXT;
	LIBRARY_KHR;
	RAY_TRACING_SKIP_TRIANGLES_KHR;
	RAY_TRACING_SKIP_AABBS_KHR;
	RAY_TRACING_NO_NULL_ANY_HIT_SHADERS_KHR;
	RAY_TRACING_NO_NULL_CLOSEST_HIT_SHADERS_KHR;
	RAY_TRACING_NO_NULL_MISS_SHADERS_KHR;
	RAY_TRACING_NO_NULL_INTERSECTION_SHADERS_KHR;
	INDIRECT_BINDABLE_NV;
	RAY_TRACING_SHADER_GROUP_HANDLE_CAPTURE_REPLAY_KHR;
}

enum VkPipelineShaderStageCreateFlag {
	ALLOW_VARYING_SUBGROUP_SIZE_EXT;
	REQUIRE_FULL_SUBGROUPS_EXT;
}

enum VkShaderStageFlag {
	VERTEX;
	TESSELLATION_CONTROL;
	TESSELLATION_EVALUATION;
	GEOMETRY;
	FRAGMENT;
	COMPUTE;
	TASK_NV;
	MESH_NV;
	RAYGEN_KHR;
	ANY_HIT_KHR;
	CLOSEST_HIT_KHR;
	MISS_KHR;
	INTERSECTION_KHR;
	CALLABLE_KHR;
	//ALL_GRAPHICS = 0x0000001F,
	//ALL = 0x7FFFFFFF,
}

abstract VkSpecializationInfo(hl.Bytes) {
}

abstract ArrayStruct<T>(hl.Bytes) {
}

abstract IntArray<T>(hl.Bytes) {
	public function new( arr : Array<T> ) {
		throw "TODO";
	}
}

abstract NextPtr(hl.Bytes) {
}

enum VkCommandPoolCreateFlag {
	TRANSIENT;
	RESET_COMMAND_BUFFER;
	PROTECTED;
}

@:struct class VkCommandPoolCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkCommandPoolCreateFlag>;
	public var queueFamilyIndex : Int;
	public function new() {
		type = COMMAND_POOL_CREATE_INFO;
	}
}

@:enum abstract VkCommandBufferLevel(Int) {
	var PRIMARY = 0;
	var SECONDARY = 1;
}

@:struct class VkCommandBufferAllocateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var commandPool : VkCommandPool;
	public var level : VkCommandBufferLevel;
	public var commandBufferCount : Int;
	public function new() {
		type = COMMAND_BUFFER_ALLOCATE_INFO;
	}
}

abstract VkCommandPool(hl.Abstract<"vk_command_pool">) {
}

enum VkFenceCreateFlag {
	SIGNALED;
}

@:struct class VkFenceCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkFenceCreateFlag>;
	public function new() {
		type = FENCE_CREATE_INFO;
	}
}

abstract VkFence(hl.Abstract<"vk_fence">) {
}


@:struct class VkPipelineShaderStage {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkPipelineShaderStageCreateFlag>;
	public var stage : haxe.EnumFlags<VkShaderStageFlag>;
	public var module : VkShaderModule;
	public var name : hl.Bytes;
	public var specializationInfo : VkSpecializationInfo;
	public function new() {
		type = PIPELINE_SHADER_STAGE_CREATE_INFO;
	}
}

enum abstract VkVertexInputRate(Int) {
	var VERTEX = 0;
	var INSTANCE = 1;
}

enum abstract VkFormat(Int) {
	var UNDEFINED = 0;
	var R4G4_UNORM_PACK8 = 1;
	var R4G4B4A4_UNORM_PACK16 = 2;
	var B4G4R4A4_UNORM_PACK16 = 3;
	var R5G6B5_UNORM_PACK16 = 4;
	var B5G6R5_UNORM_PACK16 = 5;
	var R5G5B5A1_UNORM_PACK16 = 6;
	var B5G5R5A1_UNORM_PACK16 = 7;
	var A1R5G5B5_UNORM_PACK16 = 8;
	var R8_UNORM = 9;
	var R8_SNORM = 10;
	var R8_USCALED = 11;
	var R8_SSCALED = 12;
	var R8_UINT = 13;
	var R8_SINT = 14;
	var R8_SRGB = 15;
	var R8G8_UNORM = 16;
	var R8G8_SNORM = 17;
	var R8G8_USCALED = 18;
	var R8G8_SSCALED = 19;
	var R8G8_UINT = 20;
	var R8G8_SINT = 21;
	var R8G8_SRGB = 22;
	var R8G8B8_UNORM = 23;
	var R8G8B8_SNORM = 24;
	var R8G8B8_USCALED = 25;
	var R8G8B8_SSCALED = 26;
	var R8G8B8_UINT = 27;
	var R8G8B8_SINT = 28;
	var R8G8B8_SRGB = 29;
	var B8G8R8_UNORM = 30;
	var B8G8R8_SNORM = 31;
	var B8G8R8_USCALED = 32;
	var B8G8R8_SSCALED = 33;
	var B8G8R8_UINT = 34;
	var B8G8R8_SINT = 35;
	var B8G8R8_SRGB = 36;
	var R8G8B8A8_UNORM = 37;
	var R8G8B8A8_SNORM = 38;
	var R8G8B8A8_USCALED = 39;
	var R8G8B8A8_SSCALED = 40;
	var R8G8B8A8_UINT = 41;
	var R8G8B8A8_SINT = 42;
	var R8G8B8A8_SRGB = 43;
	var B8G8R8A8_UNORM = 44;
	var B8G8R8A8_SNORM = 45;
	var B8G8R8A8_USCALED = 46;
	var B8G8R8A8_SSCALED = 47;
	var B8G8R8A8_UINT = 48;
	var B8G8R8A8_SINT = 49;
	var B8G8R8A8_SRGB = 50;
	var A8B8G8R8_UNORM_PACK32 = 51;
	var A8B8G8R8_SNORM_PACK32 = 52;
	var A8B8G8R8_USCALED_PACK32 = 53;
	var A8B8G8R8_SSCALED_PACK32 = 54;
	var A8B8G8R8_UINT_PACK32 = 55;
	var A8B8G8R8_SINT_PACK32 = 56;
	var A8B8G8R8_SRGB_PACK32 = 57;
	var A2R10G10B10_UNORM_PACK32 = 58;
	var A2R10G10B10_SNORM_PACK32 = 59;
	var A2R10G10B10_USCALED_PACK32 = 60;
	var A2R10G10B10_SSCALED_PACK32 = 61;
	var A2R10G10B10_UINT_PACK32 = 62;
	var A2R10G10B10_SINT_PACK32 = 63;
	var A2B10G10R10_UNORM_PACK32 = 64;
	var A2B10G10R10_SNORM_PACK32 = 65;
	var A2B10G10R10_USCALED_PACK32 = 66;
	var A2B10G10R10_SSCALED_PACK32 = 67;
	var A2B10G10R10_UINT_PACK32 = 68;
	var A2B10G10R10_SINT_PACK32 = 69;
	var R16_UNORM = 70;
	var R16_SNORM = 71;
	var R16_USCALED = 72;
	var R16_SSCALED = 73;
	var R16_UINT = 74;
	var R16_SINT = 75;
	var R16_SFLOAT = 76;
	var R16G16_UNORM = 77;
	var R16G16_SNORM = 78;
	var R16G16_USCALED = 79;
	var R16G16_SSCALED = 80;
	var R16G16_UINT = 81;
	var R16G16_SINT = 82;
	var R16G16_SFLOAT = 83;
	var R16G16B16_UNORM = 84;
	var R16G16B16_SNORM = 85;
	var R16G16B16_USCALED = 86;
	var R16G16B16_SSCALED = 87;
	var R16G16B16_UINT = 88;
	var R16G16B16_SINT = 89;
	var R16G16B16_SFLOAT = 90;
	var R16G16B16A16_UNORM = 91;
	var R16G16B16A16_SNORM = 92;
	var R16G16B16A16_USCALED = 93;
	var R16G16B16A16_SSCALED = 94;
	var R16G16B16A16_UINT = 95;
	var R16G16B16A16_SINT = 96;
	var R16G16B16A16_SFLOAT = 97;
	var R32_UINT = 98;
	var R32_SINT = 99;
	var R32_SFLOAT = 100;
	var R32G32_UINT = 101;
	var R32G32_SINT = 102;
	var R32G32_SFLOAT = 103;
	var R32G32B32_UINT = 104;
	var R32G32B32_SINT = 105;
	var R32G32B32_SFLOAT = 106;
	var R32G32B32A32_UINT = 107;
	var R32G32B32A32_SINT = 108;
	var R32G32B32A32_SFLOAT = 109;
	var R64_UINT = 110;
	var R64_SINT = 111;
	var R64_SFLOAT = 112;
	var R64G64_UINT = 113;
	var R64G64_SINT = 114;
	var R64G64_SFLOAT = 115;
	var R64G64B64_UINT = 116;
	var R64G64B64_SINT = 117;
	var R64G64B64_SFLOAT = 118;
	var R64G64B64A64_UINT = 119;
	var R64G64B64A64_SINT = 120;
	var R64G64B64A64_SFLOAT = 121;
	var B10G11R11_UFLOAT_PACK32 = 122;
	var E5B9G9R9_UFLOAT_PACK32 = 123;
	var D16_UNORM = 124;
	var X8_D24_UNORM_PACK32 = 125;
	var D32_SFLOAT = 126;
	var S8_UINT = 127;
	var D16_UNORM_S8_UINT = 128;
	var D24_UNORM_S8_UINT = 129;
	var D32_SFLOAT_S8_UINT = 130;
	var BC1_RGB_UNORM_BLOCK = 131;
	var BC1_RGB_SRGB_BLOCK = 132;
	var BC1_RGBA_UNORM_BLOCK = 133;
	var BC1_RGBA_SRGB_BLOCK = 134;
	var BC2_UNORM_BLOCK = 135;
	var BC2_SRGB_BLOCK = 136;
	var BC3_UNORM_BLOCK = 137;
	var BC3_SRGB_BLOCK = 138;
	var BC4_UNORM_BLOCK = 139;
	var BC4_SNORM_BLOCK = 140;
	var BC5_UNORM_BLOCK = 141;
	var BC5_SNORM_BLOCK = 142;
	var BC6H_UFLOAT_BLOCK = 143;
	var BC6H_SFLOAT_BLOCK = 144;
	var BC7_UNORM_BLOCK = 145;
	var BC7_SRGB_BLOCK = 146;
	var ETC2_R8G8B8_UNORM_BLOCK = 147;
	var ETC2_R8G8B8_SRGB_BLOCK = 148;
	var ETC2_R8G8B8A1_UNORM_BLOCK = 149;
	var ETC2_R8G8B8A1_SRGB_BLOCK = 150;
	var ETC2_R8G8B8A8_UNORM_BLOCK = 151;
	var ETC2_R8G8B8A8_SRGB_BLOCK = 152;
	var EAC_R11_UNORM_BLOCK = 153;
	var EAC_R11_SNORM_BLOCK = 154;
	var EAC_R11G11_UNORM_BLOCK = 155;
	var EAC_R11G11_SNORM_BLOCK = 156;
	var ASTC_4x4_UNORM_BLOCK = 157;
	var ASTC_4x4_SRGB_BLOCK = 158;
	var ASTC_5x4_UNORM_BLOCK = 159;
	var ASTC_5x4_SRGB_BLOCK = 160;
	var ASTC_5x5_UNORM_BLOCK = 161;
	var ASTC_5x5_SRGB_BLOCK = 162;
	var ASTC_6x5_UNORM_BLOCK = 163;
	var ASTC_6x5_SRGB_BLOCK = 164;
	var ASTC_6x6_UNORM_BLOCK = 165;
	var ASTC_6x6_SRGB_BLOCK = 166;
	var ASTC_8x5_UNORM_BLOCK = 167;
	var ASTC_8x5_SRGB_BLOCK = 168;
	var ASTC_8x6_UNORM_BLOCK = 169;
	var ASTC_8x6_SRGB_BLOCK = 170;
	var ASTC_8x8_UNORM_BLOCK = 171;
	var ASTC_8x8_SRGB_BLOCK = 172;
	var ASTC_10x5_UNORM_BLOCK = 173;
	var ASTC_10x5_SRGB_BLOCK = 174;
	var ASTC_10x6_UNORM_BLOCK = 175;
	var ASTC_10x6_SRGB_BLOCK = 176;
	var ASTC_10x8_UNORM_BLOCK = 177;
	var ASTC_10x8_SRGB_BLOCK = 178;
	var ASTC_10x10_UNORM_BLOCK = 179;
	var ASTC_10x10_SRGB_BLOCK = 180;
	var ASTC_12x10_UNORM_BLOCK = 181;
	var ASTC_12x10_SRGB_BLOCK = 182;
	var ASTC_12x12_UNORM_BLOCK = 183;
	var ASTC_12x12_SRGB_BLOCK = 184;
	var G8B8G8R8_422_UNORM = 1000156000;
	var B8G8R8G8_422_UNORM = 1000156001;
	var G8_B8_R8_3PLANE_420_UNORM = 1000156002;
	var G8_B8R8_2PLANE_420_UNORM = 1000156003;
	var G8_B8_R8_3PLANE_422_UNORM = 1000156004;
	var G8_B8R8_2PLANE_422_UNORM = 1000156005;
	var G8_B8_R8_3PLANE_444_UNORM = 1000156006;
	var R10X6_UNORM_PACK16 = 1000156007;
	var R10X6G10X6_UNORM_2PACK16 = 1000156008;
	var R10X6G10X6B10X6A10X6_UNORM_4PACK16 = 1000156009;
	var G10X6B10X6G10X6R10X6_422_UNORM_4PACK16 = 1000156010;
	var B10X6G10X6R10X6G10X6_422_UNORM_4PACK16 = 1000156011;
	var G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16 = 1000156012;
	var G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16 = 1000156013;
	var G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16 = 1000156014;
	var G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16 = 1000156015;
	var G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16 = 1000156016;
	var R12X4_UNORM_PACK16 = 1000156017;
	var R12X4G12X4_UNORM_2PACK16 = 1000156018;
	var R12X4G12X4B12X4A12X4_UNORM_4PACK16 = 1000156019;
	var G12X4B12X4G12X4R12X4_422_UNORM_4PACK16 = 1000156020;
	var B12X4G12X4R12X4G12X4_422_UNORM_4PACK16 = 1000156021;
	var G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16 = 1000156022;
	var G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16 = 1000156023;
	var G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16 = 1000156024;
	var G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16 = 1000156025;
	var G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16 = 1000156026;
	var G16B16G16R16_422_UNORM = 1000156027;
	var B16G16R16G16_422_UNORM = 1000156028;
	var G16_B16_R16_3PLANE_420_UNORM = 1000156029;
	var G16_B16R16_2PLANE_420_UNORM = 1000156030;
	var G16_B16_R16_3PLANE_422_UNORM = 1000156031;
	var G16_B16R16_2PLANE_422_UNORM = 1000156032;
	var G16_B16_R16_3PLANE_444_UNORM = 1000156033;
	var PVRTC1_2BPP_UNORM_BLOCK_IMG = 1000054000;
	var PVRTC1_4BPP_UNORM_BLOCK_IMG = 1000054001;
	var PVRTC2_2BPP_UNORM_BLOCK_IMG = 1000054002;
	var PVRTC2_4BPP_UNORM_BLOCK_IMG = 1000054003;
	var PVRTC1_2BPP_SRGB_BLOCK_IMG = 1000054004;
	var PVRTC1_4BPP_SRGB_BLOCK_IMG = 1000054005;
	var PVRTC2_2BPP_SRGB_BLOCK_IMG = 1000054006;
	var PVRTC2_4BPP_SRGB_BLOCK_IMG = 1000054007;
	var ASTC_4x4_SFLOAT_BLOCK_EXT = 1000066000;
	var ASTC_5x4_SFLOAT_BLOCK_EXT = 1000066001;
	var ASTC_5x5_SFLOAT_BLOCK_EXT = 1000066002;
	var ASTC_6x5_SFLOAT_BLOCK_EXT = 1000066003;
	var ASTC_6x6_SFLOAT_BLOCK_EXT = 1000066004;
	var ASTC_8x5_SFLOAT_BLOCK_EXT = 1000066005;
	var ASTC_8x6_SFLOAT_BLOCK_EXT = 1000066006;
	var ASTC_8x8_SFLOAT_BLOCK_EXT = 1000066007;
	var ASTC_10x5_SFLOAT_BLOCK_EXT = 1000066008;
	var ASTC_10x6_SFLOAT_BLOCK_EXT = 1000066009;
	var ASTC_10x8_SFLOAT_BLOCK_EXT = 1000066010;
	var ASTC_10x10_SFLOAT_BLOCK_EXT = 1000066011;
	var ASTC_12x10_SFLOAT_BLOCK_EXT = 1000066012;
	var ASTC_12x12_SFLOAT_BLOCK_EXT = 1000066013;
	var A4R4G4B4_UNORM_PACK16_EXT = 1000340000;
	var A4B4G4R4_UNORM_PACK16_EXT = 1000340001;
}

@:struct class VkVertexInputBindingDescription {
	public var binding : Int;
	public var stride : Int;
	public var inputRate : VkVertexInputRate;
	public function new() {}
}

@:struct class VkVertexInputAttributeDescription {
	public var location : Int;
	public var binding : Int;
	public var format : VkFormat;
	public var offset : Int;
	public function new() {}
}

abstract UnusedFlags(Int) {
}

@:struct class VkPipelineVertexInput {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var vertexBindingDescriptionCount : Int;
	public var vertexBindingDescriptions : ArrayStruct<VkVertexInputBindingDescription>;
	public var vertexAttributeDescriptionCount : Int;
	public var vertexAttributeDescriptions : ArrayStruct<VkVertexInputAttributeDescription>;
	public function new() {
		type = PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;
	}
}

enum abstract VkPrimitiveTopology(Int) {
	var POINT_LIST = 0;
	var LINE_LIST = 1;
	var LINE_STRIP = 2;
	var TRIANGLE_LIST = 3;
	var TRIANGLE_STRIP = 4;
	var TRIANGLE_FAN = 5;
	var LINE_LIST_WITH_ADJACENCY = 6;
	var LINE_STRIP_WITH_ADJACENCY = 7;
	var TRIANGLE_LIST_WITH_ADJACENCY = 8;
	var TRIANGLE_STRIP_WITH_ADJACENCY = 9;
	var PATCH_LIST = 10;
}

abstract VkBool32(Int) {
	@:to function toBool() return this != 0 ? true : false;
	@:from static function fromBool( b : Bool ) : VkBool32 {
		return cast (b ? 1 : 0);
	}
}

@:struct class VkPipelineInputAssembly {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var topology : VkPrimitiveTopology;
	public var primitiveRestartEnable : VkBool32;
	public function new() {
		type = PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
	}
}

@:struct class VkPipelineTessellation {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var patchControlPoints : Int;
	public function new() {
		type = PIPELINE_TESSELLATION_STATE_CREATE_INFO;
	}
}

@:struct class VkViewport {
	public var x : Single;
	public var y : Single;
	public var width : Single;
	public var height : Single;
	public var minDepth : Single;
	public var maxDepth : Single;
	public function new() {}
}

@:struct class VkRect2D {
	public var offsetX : Int;
	public var offsetY : Int;
	public var extendX : Int;
	public var extendY : Int;
	public function new() {}
}

@:struct class VkPipelineViewport {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var viewportCount : Int;
	public var viewports : ArrayStruct<VkViewport>;
	public var scissorCount : Int;
	public var scissors : ArrayStruct<VkRect2D>;
	public function new() {
		type = PIPELINE_VIEWPORT_STATE_CREATE_INFO;
	}
}

enum abstract VkPolygonMode(Int) {
	var FILL = 0;
	var LINE = 1;
	var POINT = 2;
	var FILL_RECTANGLE_NV = 1000153000;
}

enum abstract VkCullModeFlags(Int) {
	var NONE = 0;
	var FRONT = 1;
	var BACK = 2;
	var FRONT_AND_BACK = 3;
}

enum abstract VkFrontFace(Int) {
	var COUNTER_CLOCKWISE = 0;
	var CLOCKWISE = 1;
}

@:struct class VkPipelineRasterization {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var depthClampEnable : VkBool32;
	public var rasterizerDiscardEnable : VkBool32;
	public var polygonMode : VkPolygonMode;
	public var cullMode : VkCullModeFlags;
	public var frontFace : VkFrontFace;
	public var depthBiasEnable : VkBool32;
	public var depthBiasConstantFactor : Single;
	public var depthBiasClamp : Single;
	public var depthBiasSlopeFactor : Single;
	public var lineWidth : Single;
	public function new() {
		type = PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
	}
}

@:struct class VkPipelineMultisample {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var rasterizationSamples : Int;
	public var sampleShadingEnable : VkBool32;
	public var minSampleShading : Single;
	public var sampleMask : IntArray<Int>;
	public var alphaToCoverageEnable : VkBool32;
	public var alphaToOneEnable : VkBool32;
	public function new() {
		type = PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
	}
}

enum abstract VkCompareOp(Int) {
	var NEVER = 0;
	var LESS = 1;
	var EQUAL = 2;
	var LESS_OR_EQUAL = 3;
	var GREATER = 4;
	var NOT_EQUAL = 5;
	var GREATER_OR_EQUAL = 6;
	var ALWAYS = 7;
}

enum abstract VkStencilOp(Int) {
	var KEEP = 0;
	var ZERO = 1;
	var REPLACE = 2;
	var INCREMENT_AND_CLAMP = 3;
	var DECREMENT_AND_CLAMP = 4;
	var INVERT = 5;
	var INCREMENT_AND_WRAP = 6;
	var DECREMENT_AND_WRAP = 7;
}

@:struct class VkPipelineDepthStencil {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var depthTestEnable : VkBool32;
	public var depthWriteEnable : VkBool32;
	public var depthCompareOp : VkCompareOp;
	public var depthBoundsTestEnable : VkBool32;
	public var stencilTestEnable : VkBool32;

	public var frontFail : VkStencilOp;
	public var frontPass : VkStencilOp;
	public var frontDepthFail : VkStencilOp;
	public var frontCompare : VkStencilOp;
	public var frontMask : Int;
	public var frontWrite : Int;
	public var frontReference : Int;

	public var backFail : VkStencilOp;
	public var backPass : VkStencilOp;
	public var backDepthFail : VkStencilOp;
	public var backCompare : VkStencilOp;
	public var backMask : Int;
	public var backWrite : Int;
	public var backReference : Int;

	public var minDepthBounds : Single;
	public var maxDepthBounds : Single;
	public function new() {
		type = PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;
	}
}

enum abstract VkLogicOp(Int) {
	var CLEAR = 0;
	var AND = 1;
	var AND_REVERSE = 2;
	var COPY = 3;
	var AND_INVERTED = 4;
	var NO_OP = 5;
	var XOR = 6;
	var OR = 7;
	var NOR = 8;
	var EQUIVALENT = 9;
	var INVERT = 10;
	var OR_REVERSE = 11;
	var COPY_INVERTED = 12;
	var OR_INVERTED = 13;
	var NAND = 14;
	var SET = 15;
}

enum abstract VkBlendFactor(Int) {
	var ZERO = 0;
	var ONE = 1;
	var SRC_COLOR = 2;
	var ONE_MINUS_SRC_COLOR = 3;
	var DST_COLOR = 4;
	var ONE_MINUS_DST_COLOR = 5;
	var SRC_ALPHA = 6;
	var ONE_MINUS_SRC_ALPHA = 7;
	var DST_ALPHA = 8;
	var ONE_MINUS_DST_ALPHA = 9;
	var CONSTANT_COLOR = 10;
	var ONE_MINUS_CONSTANT_COLOR = 11;
	var CONSTANT_ALPHA = 12;
	var ONE_MINUS_CONSTANT_ALPHA = 13;
	var SRC_ALPHA_SATURATE = 14;
	var SRC1_COLOR = 15;
	var ONE_MINUS_SRC1_COLOR = 16;
	var SRC1_ALPHA = 17;
	var ONE_MINUS_SRC1_ALPHA = 18;
}

enum abstract VkBlendOp(Int) {
	var ADD = 0;
	var SUBTRACT = 1;
	var REVERSE_SUBTRACT = 2;
	var MIN = 3;
	var MAX = 4;
	var ZERO_EXT = 1000148000;
	var SRC_EXT = 1000148001;
	var DST_EXT = 1000148002;
	var SRC_OVER_EXT = 1000148003;
	var DST_OVER_EXT = 1000148004;
	var SRC_IN_EXT = 1000148005;
	var DST_IN_EXT = 1000148006;
	var SRC_OUT_EXT = 1000148007;
	var DST_OUT_EXT = 1000148008;
	var SRC_ATOP_EXT = 1000148009;
	var DST_ATOP_EXT = 1000148010;
	var XOR_EXT = 1000148011;
	var MULTIPLY_EXT = 1000148012;
	var SCREEN_EXT = 1000148013;
	var OVERLAY_EXT = 1000148014;
	var DARKEN_EXT = 1000148015;
	var LIGHTEN_EXT = 1000148016;
	var COLORDODGE_EXT = 1000148017;
	var COLORBURN_EXT = 1000148018;
	var HARDLIGHT_EXT = 1000148019;
	var SOFTLIGHT_EXT = 1000148020;
	var DIFFERENCE_EXT = 1000148021;
	var EXCLUSION_EXT = 1000148022;
	var INVERT_EXT = 1000148023;
	var INVERT_RGB_EXT = 1000148024;
	var LINEARDODGE_EXT = 1000148025;
	var LINEARBURN_EXT = 1000148026;
	var VIVIDLIGHT_EXT = 1000148027;
	var LINEARLIGHT_EXT = 1000148028;
	var PINLIGHT_EXT = 1000148029;
	var HARDMIX_EXT = 1000148030;
	var HSL_HUE_EXT = 1000148031;
	var HSL_SATURATION_EXT = 1000148032;
	var HSL_COLOR_EXT = 1000148033;
	var HSL_LUMINOSITY_EXT = 1000148034;
	var PLUS_EXT = 1000148035;
	var PLUS_CLAMPED_EXT = 1000148036;
	var PLUS_CLAMPED_ALPHA_EXT = 1000148037;
	var PLUS_DARKER_EXT = 1000148038;
	var MINUS_EXT = 1000148039;
	var MINUS_CLAMPED_EXT = 1000148040;
	var CONTRAST_EXT = 1000148041;
	var INVERT_OVG_EXT = 1000148042;
	var RED_EXT = 1000148043;
	var GREEN_EXT = 1000148044;
	var BLUE_EXT = 1000148045;
}

@:struct class VkPipelineColorBlendAttachmentState {
	public var blendEnable : VkBool32;
	public var srcColorBlendFactor : VkBlendFactor;
	public var dstColorBlendFactor : VkBlendFactor;
	public var colorBlendOp : VkBlendOp;
	public var srcAlphaBlendFactor : VkBlendFactor;
	public var dstAlphaBlendFactor : VkBlendFactor;
	public var alphaBlendOp : VkBlendOp;
	public var colorWriteMask : Int; // RGBA
	public function new() {}
}

@:struct class VkPipelineColorBlend {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var logicOpEnable : VkBool32;
	public var logicOp : VkLogicOp;
	public var attachmentCount : Int;
	public var attachments : ArrayStruct<VkPipelineColorBlendAttachmentState>;
	public var blendConstant0 : Single;
	public var blendConstant1 : Single;
	public var blendConstant2 : Single;
	public var blendConstant3 : Single;
	public function new() {
		type = PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
	}
}

enum abstract VkDynamicState(Int) {
	var VIEWPORT = 0;
	var SCISSOR = 1;
	var LINE_WIDTH = 2;
	var DEPTH_BIAS = 3;
	var BLEND_CONSTANTS = 4;
	var DEPTH_BOUNDS = 5;
	var STENCIL_COMPARE_MASK = 6;
	var STENCIL_WRITE_MASK = 7;
	var STENCIL_REFERENCE = 8;
	var VIEWPORT_W_SCALING_NV = 1000087000;
	var DISCARD_RECTANGLE_EXT = 1000099000;
	var SAMPLE_LOCATIONS_EXT = 1000143000;
	var RAY_TRACING_PIPELINE_STACK_SIZE_KHR = 1000347000;
	var VIEWPORT_SHADING_RATE_PALETTE_NV = 1000164004;
	var VIEWPORT_COARSE_SAMPLE_ORDER_NV = 1000164006;
	var EXCLUSIVE_SCISSOR_NV = 1000205001;
	var FRAGMENT_SHADING_RATE_KHR = 1000226000;
	var LINE_STIPPLE_EXT = 1000259000;
	var CULL_MODE_EXT = 1000267000;
	var FRONT_FACE_EXT = 1000267001;
	var PRIMITIVE_TOPOLOGY_EXT = 1000267002;
	var VIEWPORT_WITH_COUNT_EXT = 1000267003;
	var SCISSOR_WITH_COUNT_EXT = 1000267004;
	var VERTEX_INPUT_BINDING_STRIDE_EXT = 1000267005;
	var DEPTH_TEST_ENABLE_EXT = 1000267006;
	var DEPTH_WRITE_ENABLE_EXT = 1000267007;
	var DEPTH_COMPARE_OP_EXT = 1000267008;
	var DEPTH_BOUNDS_TEST_ENABLE_EXT = 1000267009;
	var STENCIL_TEST_ENABLE_EXT = 1000267010;
	var STENCIL_OP_EXT = 1000267011;
}

enum abstract VkDescriptorType(Int) {
	var SAMPLER = 0;
	var COMBINED_IMAGE_SAMPLER = 1;
	var SAMPLED_IMAGE = 2;
	var STORAGE_IMAGE = 3;
	var UNIFORM_TEXEL_BUFFER = 4;
	var STORAGE_TEXEL_BUFFER = 5;
	var UNIFORM_BUFFER = 6;
	var STORAGE_BUFFER = 7;
	var UNIFORM_BUFFER_DYNAMIC = 8;
	var STORAGE_BUFFER_DYNAMIC = 9;
	var INPUT_ATTACHMENT = 10;
	var INLINE_UNIFORM_BLOCK_EXT = 1000138000;
	var ACCELERATION_STRUCTURE_KHR = 1000150000;
	var ACCELERATION_STRUCTURE_NV = 1000165000;
	var MUTABLE_VALVE = 1000351000;
}

@:struct class VkPipelineDynamic {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var dynamicStateCount : Int;
	public var dynamicStates : IntArray<VkDynamicState>;
	public function new() {
		type = PIPELINE_DYNAMIC_STATE_CREATE_INFO;
	}
}

@:struct class VkPushConstantRange {
	public var stageFlags : haxe.EnumFlags<VkShaderStageFlag>;
	public var offset : Int;
	public var size : Int;
	public function new() {}
}

@:struct class VkDescriptorSetLayoutBinding {
	public var binding : Int;
	public var descriptorType : VkDescriptorType;
	public var descriptorCount : Int;
	public var stageFlags : haxe.EnumFlags<VkShaderStageFlag>;
	public var immutableSamplers : Any; //VkSampler
	public function new() {}
}

enum VkDescriptorSetLayoutCreateFlag {
	PUSH_DESCRIPTOR_KHR;
	UPDATE_AFTER_BIND_POOL;
	HOST_ONLY_POOL_VALVE;
}

@:struct class VkDescriptorSetLayoutCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkDescriptorSetLayoutCreateFlag>;
	public var bindingCount : Int;
	public var bindings : ArrayStruct<VkDescriptorSetLayoutBinding>;
	public function new() {
		type = DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
	}
}

@:struct class VkPipelineLayoutCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var setLayoutCount : Int;
	public var setLayouts : ArrayStruct<VkDescriptorSetLayout>;
	public var pushConstantRangeCount : Int;
	public var pushConstantRanges : ArrayStruct<VkPushConstantRange>;
	public function new() {
		type = PIPELINE_LAYOUT_CREATE_INFO;
	}
}

enum VkAttachmentDescriptionFlag {
	MAY_ALIAS;
}

enum abstract VkAttachmentLoadOp(Int) {
	var LOAD = 0;
	var CLEAR = 1;
	var DONT_CARE = 2;
}

enum abstract VkAttachmentStoreOp(Int) {
	var STORE = 0;
	var DONT_CARE = 1;
	var STORE_OP_NONE_QCOM = 1000301000;
}

@:struct class VkAttachmentDescription {
	public var flags : haxe.EnumFlags<VkAttachmentDescriptionFlag>;
	public var format : VkFormat;
	public var samples : Int;
	public var loadOp : VkAttachmentLoadOp;
	public var storeOp : VkAttachmentStoreOp;
	public var stencilLoadOp : VkAttachmentLoadOp;
	public var stencilStoreOp : VkAttachmentStoreOp;
	public var initialLayout : VkImageLayout;
	public var finalLayout : VkImageLayout;
	public function new() {}
}

enum VkSubpassDescriptionFlag {
	PER_VIEW_ATTRIBUTES_NVX;
	PER_VIEW_POSITION_X_ONLY_NVX;
	FRAGMENT_REGION_QCOM;
	SHADER_RESOLVE_QCOM;
}

enum abstract VkPipelineBindPoint(Int) {
	var GRAPHICS = 0;
	var COMPUTE = 1;
	var RAY_TRACING_KHR = 1000165000;
}

enum abstract VkImageLayout(Int) {
	var UNDEFINED = 0;
	var GENERAL = 1;
	var COLOR_ATTACHMENT_OPTIMAL = 2;
	var DEPTH_STENCIL_ATTACHMENT_OPTIMAL = 3;
	var DEPTH_STENCIL_READ_ONLY_OPTIMAL = 4;
	var SHADER_READ_ONLY_OPTIMAL = 5;
	var TRANSFER_SRC_OPTIMAL = 6;
	var TRANSFER_DST_OPTIMAL = 7;
	var PREINITIALIZED = 8;
	var DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL = 1000117000;
	var DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL = 1000117001;
	var DEPTH_ATTACHMENT_OPTIMAL = 1000241000;
	var DEPTH_READ_ONLY_OPTIMAL = 1000241001;
	var STENCIL_ATTACHMENT_OPTIMAL = 1000241002;
	var STENCIL_READ_ONLY_OPTIMAL = 1000241003;
	var PRESENT_SRC_KHR = 1000001002;
	var SHARED_PRESENT_KHR = 1000111000;
	var SHADING_RATE_OPTIMAL_NV = 1000164003;
	var FRAGMENT_DENSITY_MAP_OPTIMAL_EXT = 1000218000;
	var READ_ONLY_OPTIMAL_KHR = 1000314000;
	var ATTACHMENT_OPTIMAL_KHR = 1000314001;
}

@:struct class VkAttachmentReference {
	public var attachment : Int;
	public var layout : VkImageLayout;
	public function new() {}
}

@:struct class VkSubpassDescription {
	public var flags : haxe.EnumFlags<VkSubpassDescriptionFlag>;
	public var pipelineBindPoint : VkPipelineBindPoint;
	public var inputAttachmentCount : Int;
	public var inputAttachments : ArrayStruct<VkAttachmentReference>;
	public var colorAttachmentCount : Int;
	public var colorAttachments : ArrayStruct<VkAttachmentReference>;
	public var resolveAttachments : ArrayStruct<VkAttachmentReference>;
	public var depthStencilAttachment : ArrayStruct<VkAttachmentReference>;
	public var preserveAttachmentCount : Int;
	public var preserveAttachments : IntArray<Int>;
	public function new() {}
}

enum VkPipelineStageFlag {
	TOP_OF_PIPE;
	DRAW_INDIRECT;
	VERTEX_INPUT;
	VERTEX_SHADER;
	TESSELLATION_CONTROL_SHADER;
	TESSELLATION_EVALUATION_SHADER;
	GEOMETRY_SHADER;
	FRAGMENT_SHADER;
	EARLY_FRAGMENT_TESTS;
	LATE_FRAGMENT_TESTS;
	COLOR_ATTACHMENT_OUTPUT;
	COMPUTE_SHADER;
	TRANSFER;
	BOTTOM_OF_PIPE;
	HOST;
	ALL_GRAPHICS;
	ALL_COMMANDS;
	COMMAND_PREPROCESS_NV;
	CONDITIONAL_RENDERING_EXT;
	TASK_SHADER_NV;
	MESH_SHADER_NV;
	RAY_TRACING_SHADER_KHR;
	SHADING_RATE_IMAGE_NV;
	FRAGMENT_DENSITY_PROCESS_EXT;
	TRANSFORM_FEEDBACK_EXT;
	ACCELERATION_STRUCTURE_BUILD_KHR;
}

enum VkAccessFlag {
	INDIRECT_COMMAND_READ;
	INDEX_READ;
	VERTEX_ATTRIBUTE_READ;
	UNIFORM_READ;
	INPUT_ATTACHMENT_READ;
	SHADER_READ;
	SHADER_WRITE;
	COLOR_ATTACHMENT_READ;
	COLOR_ATTACHMENT_WRITE;
	DEPTH_STENCIL_ATTACHMENT_READ;
	DEPTH_STENCIL_ATTACHMENT_WRITE;
	TRANSFER_READ;
	TRANSFER_WRITE;
	HOST_READ;
	HOST_WRITE;
	MEMORY_READ;
	MEMORY_WRITE;
	COMMAND_PREPROCESS_READ_NV;
	COMMAND_PREPROCESS_WRITE_NV;
	COLOR_ATTACHMENT_READ_NONCOHERENT_EXT;
	CONDITIONAL_RENDERING_READ_EXT;
	ACCELERATION_STRUCTURE_READ_KHR;
	ACCELERATION_STRUCTURE_WRITE_KHR;
	SHADING_RATE_IMAGE_READ_NV;
	FRAGMENT_DENSITY_MAP_READ_EXT;
	TRANSFORM_FEEDBACK_WRITE_EXT;
	TRANSFORM_FEEDBACK_COUNTER_READ_EXT;
	TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT;
}

enum VkDependencyFlag {
	BY_REGION;
	VIEW_LOCAL;
	DEVICE_GROUP;
}

@:struct class VkSubpassDependency {
	public var srcSubpass : Int;
	public var dstSubpass : Int;
	public var srcStageMask : haxe.EnumFlags<VkPipelineStageFlag>;
	public var dstStageMask : haxe.EnumFlags<VkPipelineStageFlag>;
	public var srcAccessMask : haxe.EnumFlags<VkAccessFlag>;
	public var dstAccessMask : haxe.EnumFlags<VkAccessFlag>;
	public var dependencyFlags : haxe.EnumFlags<VkDependencyFlag>;
	public function new() {}
}

@:struct class VkRenderPassCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : UnusedFlags;
	public var attachmentCount : Int;
	public var attachments : ArrayStruct<VkAttachmentDescription>;
	public var subpassCount : Int;
	public var subpasses : ArrayStruct<VkSubpassDescription>;
	public var dependencyCount : Int;
	public var dependencies : ArrayStruct<VkSubpassDependency>;
	public function new() {
		type = RENDER_PASS_CREATE_INFO;
	}
}

@:struct class VkGraphicsPipelineCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkPipelineCreateFlags>;
	public var stageCount : Int;
	public var stages : ArrayStruct<VkPipelineShaderStage>;
	public var vertexInput : VkPipelineVertexInput;
	public var inputAssembly : VkPipelineInputAssembly;
	public var tessellation : VkPipelineTessellation;
	public var viewport : VkPipelineViewport;
	public var rasterization : VkPipelineRasterization;
	public var multisample : VkPipelineMultisample;
	public var depthStencil : VkPipelineDepthStencil;
	public var colorBlend : VkPipelineColorBlend;
	public var dynamicDef : VkPipelineDynamic;
	public var layout : VkPipelineLayout;
	public var renderPass : VkRenderPass;
	public var subpass : Int;
	public var basePipelineHandle : VkGraphicsPipeline;
	public var basePipelineIndex : Int;
	public function new() {
		type = GRAPHICS_PIPELINE_CREATE_INFO;
	}
}

@:struct class VkClearValue {
	public var r : Single;
	public var g : Single;
	public var b : Single;
	public var a : Single;
	public var depth(get,set) : Single;
	public var stencil(get,set) : Int;
	public function new() {
	}
	inline function get_depth() return r;
	inline function set_depth(v) return r = v;
	inline function get_stencil() return haxe.io.FPHelper.floatToI32(g);
	inline function set_stencil(v:Int) {
		g = haxe.io.FPHelper.floatToI32(v);
		return v;
	}
}

@:struct class VkRenderPassBeginInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var renderPass : VkRenderPass;
	public var framebuffer : VkFramebuffer;
	public var renderAreaOffsetX : Int;
	public var renderAreaOffsetY : Int;
	public var renderAreaExtentX : Int;
	public var renderAreaExtentY : Int;
	public var clearValueCount : Int;
	public var clearValues : ArrayStruct<VkClearValue>;
	public function new() {
		type = RENDER_PASS_BEGIN_INFO;
	}
}

enum abstract VkSubpassContents(Int) {
	var INLINE = 0;
	var SECONDARY_COMMAND_BUFFERS = 1;
}

enum VkFramebufferCreateFlag {
	IMAGELESS;
}

@:struct class VkFramebufferCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkFramebufferCreateFlag>;
	public var renderPass : VkRenderPass;
	public var attachmentCount : Int;
	public var attachments : ArrayStruct<VkImageView>;
	public var width : Int;
	public var height : Int;
	public var layers : Int;
	public function new() {
		type = FRAMEBUFFER_CREATE_INFO;
	}
}

enum VkImageViewCreateFlag {
	FRAGMENT_DENSITY_MAP_DYNAMIC_EXT;
	FRAGMENT_DENSITY_MAP_DEFERRED_EXT;
}

enum abstract VkImageViewType(Int) {
	var TYPE_1D = 0;
	var TYPE_2D = 1;
	var TYPE_3D = 2;
	var TYPE_CUBE = 3;
	var TYPE_1D_ARRAY = 4;
	var TYPE_2D_ARRAY = 5;
	var TYPE_CUBE_ARRAY = 6;
}

enum abstract VkComponentSwizzle(Int) {
	var IDENTITY = 0;
	var ZERO = 1;
	var ONE = 2;
	var R = 3;
	var G = 4;
	var B = 5;
	var A = 6;
}

enum VkImageAspectFlag {
	COLOR;
	DEPTH;
	STENCIL;
	METADATA;
	PLANE_0;
	PLANE_1;
	PLANE_2;
	MEMORY_PLANE_0;
	MEMORY_PLANE_1;
	MEMORY_PLANE_2;
	MEMORY_PLANE_3;
}

@:struct class VkImageViewCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkImageViewCreateFlag>;
	public var image : VkImage;
	public var viewType : VkImageViewType;
	public var format : VkFormat;
	public var componentR : VkComponentSwizzle;
	public var componentG : VkComponentSwizzle;
	public var componentB : VkComponentSwizzle;
	public var componentA : VkComponentSwizzle;
	// 	subresourceRange : VkImageSubresourceRange;
	public var aspectMask : haxe.EnumFlags<VkImageAspectFlag>;
	public var baseMipLevel : Int;
	public var levelCount : Int;
	public var baseArrayLayer : Int;
	public var layerCount : Int;
	public function new() {
		type = IMAGE_VIEW_CREATE_INFO;
	}
}

enum VkBufferCreateFlag {
	SPARSE_BINDING;
	SPARSE_RESIDENCY;
	SPARSE_ALIASED;
	PROTECTED;
	DEVICE_ADDRESS_CAPTURE_REPLAY;
}

enum VkBufferUsageFlag {
	TRANSFER_SRC;
	TRANSFER_DST;
	UNIFORM_TEXEL_BUFFER;
	STORAGE_TEXEL_BUFFER;
	UNIFORM_BUFFER;
	STORAGE_BUFFER;
	INDEX_BUFFER;
	VERTEX_BUFFER;
	INDIRECT_BUFFER;
}

enum abstract VkSharingMode(Int) {
	var EXCLUSIVE = 0;
	var CONCURRENT = 1;
}

@:struct class VkBufferCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkBufferCreateFlag>;
	var __align : Int;
	public var size : Int;
	public var size64 : Int;
	public var usage : haxe.EnumFlags<VkBufferUsageFlag>;
	public var sharingMode : VkSharingMode;
	public var queueFamilyIndexCount : Int;
	public var queueFamilyIndices : IntArray<Int>;
	public function new() {
		type = BUFFER_CREATE_INFO;
	}
}

@:struct class VkMemoryRequirements {
	public var size : Int;
	public var size64 : Int;
	public var alignment : Int;
	public var alignment64 : Int;
	public var memoryTypeBits : Int;
	public function new() {}
}

@:struct class VkMemoryAllocateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var size : Int;
	public var size64 : Int;
	public var memoryTypeIndex : Int;
	public function new() {
		type = MEMORY_ALLOCATE_INFO;
	}
}

@:struct class VkDeviceSize {
	public var low : Int;
	public var high : Int;
	public function new(v=0) { low = v; }
}

enum VkMemoryPropertyFlag {
	DEVICE_LOCAL;
	HOST_VISIBLE;
	HOST_COHERENT;
	HOST_CACHED;
	LAZILY_ALLOCATED;
	PROTECTED;
	DEVICE_COHERENT_AMD;
	DEVICE_UNCACHED_AMD;
}

enum abstract ShaderKind(Int) {
	var Vertex = 0;
	var Fragment = 1;
}

typedef VkClearColorValue = VkClearValue;

@:struct class VkClearDepthStencilValue {
	public var depth : Single;
	public var stencil : Int;
	public function new() {
	}
}

@:struct class VkImageSubResourceRange {
	public var aspectMask : haxe.EnumFlags<VkImageAspectFlag>;
	public var baseMipLevel : Int;
	public var levelCount : Int;
	public var baseArrayLayer : Int;
	public var layerCount : Int;
	public function new() {
	}
}

@:struct class VkClearAttachment {
	public var aspectMask : haxe.EnumFlags<VkImageAspectFlag>;
	public var colorAttachment : Int;
	public var r : Single;
	public var g : Single;
	public var b : Single;
	public var a : Single;
	public var depth(get,set) : Single;
	public var stencil(get,set) : Int;
	public function new() {
	}
	inline function get_depth() return r;
	inline function set_depth(v) return r = v;
	inline function get_stencil() return haxe.io.FPHelper.floatToI32(g);
	inline function set_stencil(v:Int) {
		g = haxe.io.FPHelper.floatToI32(v);
		return v;
	}
}

@:struct class VkClearRect {
	public var offsetX : Int;
	public var offsetY : Int;
	public var extendX : Int;
	public var extendY : Int;
	public var baseArrayLayer : Int;
	public var layerCount : Int;
	public function new() {
	}
}

abstract VkSemaphore(hl.Abstract<"vk_semaphore">) {}

@:struct class VkSemaphoreCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	var unusedFlags : Int;
	public function new() {
		type = SEMAPHORE_CREATE_INFO;
	}
}

enum VkCommandBufferUsageFlag {
	ONE_TIME_SUBMIT;
	RENDER_PASS_CONTINUE;
	SIMULTANEOUS_USE;
}

@:struct class VkCommandBufferBeginInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkCommandBufferUsageFlag>;
	public var pInheritanceInfo : {};
	public function new() {
		type = COMMAND_BUFFER_BEGIN_INFO;
	}
}

@:struct class VkSubmitInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var waitSemaphoreCount : Int;
	public var pWaitSemaphores : ArrayStruct<VkSemaphore>;
	public var pWaitDstStageMask : ArrayStruct<haxe.EnumFlags<VkPipelineStageFlag>>;
	public var commandBufferCount : Int;
	public var pCommandBuffers : ArrayStruct<VkCommandBuffer>;
	public var signalSemaphoreCount : Int;
	public var pSignalSemaphores : ArrayStruct<VkSemaphore>;
	public function new() {
		type = SUBMIT_INFO;
	}
}

abstract VkImage(hl.Abstract<"vk_image">) {}

@:struct class VkPhysicalDeviceLimits {
	public var maxImageDimension1D : Int;
	public var maxImageDimension2D : Int;
	public var maxImageDimension3D : Int;
	public var maxImageDimensionCube : Int;
	public var maxImageArrayLayers : Int;
	public var maxTexelBufferElements : Int;
	public var maxUniformBufferRange : Int;
	public var maxStorageBufferRange : Int;
	public var maxPushConstantsSize : Int;
	public var maxMemoryAllocationCount : Int;
	public var maxSamplerAllocationCount : Int;
	public var bufferImageGranularity : Int;
	public var bufferImageGranularityHigh : Int;
	public var sparseAddressSpaceSize : hl.I64;
	public var maxBoundDescriptorSets : Int;
	public var maxPerStageDescriptorSamplers : Int;
	public var maxPerStageDescriptorUniformBuffers : Int;
	public var maxPerStageDescriptorStorageBuffers : Int;
	public var maxPerStageDescriptorSampledImages : Int;
	public var maxPerStageDescriptorStorageImages : Int;
	public var maxPerStageDescriptorInputAttachments : Int;
	public var maxPerStageResources : Int;
	public var maxDescriptorSetSamplers : Int;
	public var maxDescriptorSetUniformBuffers : Int;
	public var maxDescriptorSetUniformBuffersDynamic : Int;
	public var maxDescriptorSetStorageBuffers : Int;
	public var maxDescriptorSetStorageBuffersDynamic : Int;
	public var maxDescriptorSetSampledImages : Int;
	public var maxDescriptorSetStorageImages : Int;
	public var maxDescriptorSetInputAttachments : Int;
	public var maxVertexInputAttributes : Int;
	public var maxVertexInputBindings : Int;
	public var maxVertexInputAttributeOffset : Int;
	public var maxVertexInputBindingStride : Int;
	public var maxVertexOutputComponents : Int;
	public var maxTessellationGenerationLevel : Int;
	public var maxTessellationPatchSize : Int;
	public var maxTessellationControlPerVertexInputComponents : Int;
	public var maxTessellationControlPerVertexOutputComponents : Int;
	public var maxTessellationControlPerPatchOutputComponents : Int;
	public var maxTessellationControlTotalOutputComponents : Int;
	public var maxTessellationEvaluationInputComponents : Int;
	public var maxTessellationEvaluationOutputComponents : Int;
	public var maxGeometryShaderInvocations : Int;
	public var maxGeometryInputComponents : Int;
	public var maxGeometryOutputComponents : Int;
	public var maxGeometryOutputVertices : Int;
	public var maxGeometryTotalOutputComponents : Int;
	public var maxFragmentInputComponents : Int;
	public var maxFragmentOutputAttachments : Int;
	public var maxFragmentDualSrcAttachments : Int;
	public var maxFragmentCombinedOutputResources : Int;
	public var maxComputeSharedMemorySize : Int;
	public var maxComputeWorkGroupCount : Int;
	public var maxComputeWorkGroupCount1 : Int;
	public var maxComputeWorkGroupCount2 : Int;
	public var maxComputeWorkGroupInvocations : Int;
	public var maxComputeWorkGroupSize : Int;
	public var maxComputeWorkGroupSize1 : Int;
	public var maxComputeWorkGroupSize2 : Int;
	public var subPixelPrecisionBits : Int;
	public var subTexelPrecisionBits : Int;
	public var mipmapPrecisionBits : Int;
	public var maxDrawIndexedIndexValue : Int;
	public var maxDrawIndirectCount : Int;
	public var maxSamplerLodBias : Single;
	public var maxSamplerAnisotropy : Single;
	public var maxViewports : Int;
	public var maxViewportDimensionsW : Int;
	public var maxViewportDimensionsH : Int;
	public var viewportBoundsRange : Single;
	public var viewportBoundsRange2 : Single;
	public var viewportSubPixelBits : Int;
	public var minMemoryMapAlignment : hl.I64;
	public var minTexelBufferOffsetAlignment : hl.I64;
	public var minUniformBufferOffsetAlignment : hl.I64;
	public var minStorageBufferOffsetAlignment : hl.I64;
	public var minTexelOffset : Int;
	public var maxTexelOffset : Int;
	public var minTexelGatherOffset : Int;
	public var maxTexelGatherOffset : Int;
	public var minInterpolationOffset : Single;
	public var maxInterpolationOffset : Single;
	public var subPixelInterpolationOffsetBits : Int;
	public var maxFramebufferWidth : Int;
	public var maxFramebufferHeight : Int;
	public var maxFramebufferLayers : Int;
	public var framebufferColorSampleCounts : Int;
	public var framebufferDepthSampleCounts : Int;
	public var framebufferStencilSampleCounts : Int;
	public var framebufferNoAttachmentsSampleCounts : Int;
	public var maxColorAttachments : Int;
	public var sampledImageColorSampleCounts : Int;
	public var sampledImageIntegerSampleCounts : Int;
	public var sampledImageDepthSampleCounts : Int;
	public var sampledImageStencilSampleCounts : Int;
	public var storageImageSampleCounts : Int;
	public var maxSampleMaskWords : Int;
	public var timestampComputeAndGraphics : VkBool32;
	public var timestampPeriod : Single;
	public var maxClipDistances : Int;
	public var maxCullDistances : Int;
	public var maxCombinedClipAndCullDistances : Int;
	public var discreteQueuePriorities : Int;
	public var pointSizeRange : Single;
	public var pointSizeRange2 : Single;
	public var lineWidthRange : Single;
	public var lineWidthRange2 : Single;
	public var pointSizeGranularity : Single;
	public var lineWidthGranularity : Single;
	public var strictLines : VkBool32;
	public var standardSampleLocations : VkBool32;
	public var optimalBufferCopyOffsetAlignment : hl.I64;
	public var optimalBufferCopyRowPitchAlignment : hl.I64;
	public var nonCoherentAtomSize : hl.I64;
}

@:struct class VkFormatProperties {
	public var linearTilingFeatures : Int;
	public var optimalTilingFeatures : Int;
	public var bufferFeatures : Int;
	public function new() {}
}

@:enum abstract VkFormatFeature(Int) {
	var SAMPLED_IMAGE = 0x00000001;
	var STORAGE_IMAGE = 0x00000002;
	var STORAGE_IMAGE_ATOMIC = 0x00000004;
	var UNIFORM_TEXEL_BUFFER = 0x00000008;
	var STORAGE_TEXEL_BUFFER = 0x00000010;
	var STORAGE_TEXEL_BUFFER_ATOMIC = 0x00000020;
	var VERTEX_BUFFER = 0x00000040;
	var COLOR_ATTACHMENT = 0x00000080;
	var COLOR_ATTACHMENT_BLEND = 0x00000100;
	var DEPTH_STENCIL_ATTACHMENT = 0x00000200;
	var BLIT_SRC = 0x00000400;
	var BLIT_DST = 0x00000800;
	var SAMPLED_IMAGE_FILTER_LINEAR = 0x00001000;
	var TRANSFER_SRC = 0x00004000;
	var TRANSFER_DST = 0x00008000;
	var MIDPOINT_CHROMA_SAMPLES = 0x00020000;
	var SAMPLED_IMAGE_YCBCR_CONVERSION_LINEAR_FILTER = 0x00040000;
	var SAMPLED_IMAGE_YCBCR_CONVERSION_SEPARATE_RECONSTRUCTION_FILTER = 0x00080000;
	var SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT = 0x00100000;
	var SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT_FORCEABLE = 0x00200000;
	var DISJOINT = 0x00400000;
	var COSITED_CHROMA_SAMPLES = 0x00800000;
	var SAMPLED_IMAGE_FILTER_MINMAX = 0x00010000;
	var SAMPLED_IMAGE_FILTER_CUBIC = 0x00002000;
	var ACCELERATION_STRUCTURE_VERTEX_BUFFER = 0x20000000;
	var FRAGMENT_DENSITY_MAP = 0x01000000;
	var FRAGMENT_SHADING_RATE_ATTACHMENT = 0x40000000;
	@:op(a|b) inline function or(f:VkFormatFeature) {
		return this | f.toInt();
	}
	inline function toInt() {
		return this;
	}
}

enum VkImageCreateFlag {
	SPARSE_BINDING;
	SPARSE_RESIDENCY;
	SPARSE_ALIASED;
	MUTABLE_FORMAT;
	CUBE_COMPATIBLE;
// Provided by VK_VERSION_1_1
	_2D_ARRAY_COMPATIBLE;
	SPLIT_INSTANCE_BIND_REGIONS;
	BLOCK_TEXEL_VIEW_COMPATIBLE;
	EXTENDED_USAGE;
	DISJOINT;
	ALIAS;
	PROTECTED;
// Provided by VK_EXT_sample_locations
	SAMPLE_LOCATIONS_COMPATIBLE_DEPTH_EXT;
// Provided by VK_NV_corner_sampled_image
	CORNER_SAMPLED_NV;
// Provided by VK_EXT_fragment_density_map
	SUBSAMPLED_EXT;
}

@:enum abstract VkImageTiling(Int) {
	var OPTIMAL = 0;
	var LINEAR = 1;
}

@:enum abstract VkImageType(Int) {
	var TYPE_1D = 0;
	var TYPE_2D = 1;
	var TYPE_3D = 2;
}

enum VkImageUsageFlag {
	TRANSFER_SRC;
	TRANSFER_DST;
	SAMPLED;
	STORAGE;
	COLOR_ATTACHMENT;
	DEPTH_STENCIL_ATTACHMENT;
	TRANSIENT_ATTACHMENT;
	INPUT_ATTACHMENT;
	SHADING_RATE_IMAGE_NV;
	FRAGMENT_DENSITY_MAP_EXT;
}

@:struct class VkImageCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkImageCreateFlag>;
	public var imageType : VkImageType;
	public var format : VkFormat;
	public var width : Int;
	public var height : Int;
	public var depth : Int;
	public var mipLevels : Int;
	public var arrayLayers : Int;
	public var samples : Int;
	public var tiling : VkImageTiling;
	public var usage : haxe.EnumFlags<VkImageUsageFlag>;
	public var sharingMode : VkSharingMode;
	public var queueFamilyIndexCount : Int;
	public var pQueueFamilyIndices : ArrayStruct<Int>;
	public var initialLayout : VkImageLayout;

	public function new() {
		type = IMAGE_CREATE_INFO;
	}
}

@:struct class VkBufferImageCopy {
	public var bufferOffset : hl.I64;
	public var bufferRowLength : Int;
	public var bufferImageHeight : Int;
	public var aspectMask : haxe.EnumFlags<VkImageAspectFlag>;
	public var mipLevel : Int;
	public var baseArrayLayer : Int;
	public var layerCount : Int;
	public var imageOffsetX : Int;
	public var imageOffsetY : Int;
	public var imageOffsetZ : Int;
	public var imageWidth : Int;
	public var imageHeight : Int;
	public var imageDepth : Int;
	public function new() {
	}
}

@:struct class VkMemoryBarrier {
	var type : VkStructureType;
	var next : NextPtr;
	public var srcAccessMask : haxe.EnumFlags<VkAccessFlag>;
	public var dstAccessMask : haxe.EnumFlags<VkAccessFlag>;
	public function new() {
		type = MEMORY_BARRIER;
	}
}

@:struct class VkBufferMemoryBarrier {
	var type : VkStructureType;
	var next : NextPtr;
	public var srcAccessMask : haxe.EnumFlags<VkAccessFlag>;
	public var dstAccessMask : haxe.EnumFlags<VkAccessFlag>;
	public var srcQueueFamilyIndex : Int;
	public var dstQueueFamilyIndex : Int;
	public var buffer : VkBuffer;
	public var offset : hl.I64;
	public var size : hl.I64;
	public function new() {
		type = BUFFER_MEMORY_BARRIER;
	}
}

@:struct class VkImageMemoryBarrier {
	var type : VkStructureType;
	var next : NextPtr;
	public var srcAccessMask : haxe.EnumFlags<VkAccessFlag>;
	public var dstAccessMask : haxe.EnumFlags<VkAccessFlag>;
	public var oldLayout : VkImageLayout;
	public var newLayout : VkImageLayout;
	public var srcQueueFamilyIndex : Int;
	public var dstQueueFamilyIndex : Int;
	public var image : VkImage;
	public var aspectMask : haxe.EnumFlags<VkImageAspectFlag>;
	public var baseMipLevel : Int;
	public var levelCount : Int;
	public var baseArrayLayer : Int;
	public var layerCount : Int;
	public function new() {
		type = IMAGE_MEMORY_BARRIER;
	}
}

@:struct class VkDescriptorPoolSize {
	public var type : VkDescriptorType;
	public var descriptorCount : Int;
	public function new() {
	}
}

enum VkDescriptorPoolCreateFlag {
	FREE_DESCRIPTOR_SET;
	UPDATE_AFTER_BIND;
	HOST_ONLY_VALVE;
}

@:struct class VkDescriptorPoolCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkDescriptorPoolCreateFlag>;
	public var maxSets : Int;
	public var poolSizeCount : Int;
	public var pPoolSizes : ArrayStruct<VkDescriptorPoolSize>;
	public function new() {
		type = DESCRIPTOR_POOL_CREATE_INFO;
	}
}

@:struct class VkDescriptorSetAllocateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var descriptorPool : VkDescriptorPool;
	public var descriptorSetCount : Int;
	public var pSetLayouts : ArrayStruct<VkDescriptorSetLayout>;
	public function new() {
		type = DESCRIPTOR_SET_ALLOCATE_INFO;
	}
}

@:struct class VkDescriptorImageInfo {
	public var sampler : VkSampler;
	public var imageView : VkImageView;
	public var imageLayout : VkImageLayout;
	public function new() {
	}
}


@:struct class VkDescriptorBufferInfo {
	public var buffer : VkBuffer;
	public var offset : hl.I64;
	public var range : hl.I64;
	public function new() {
	}
}

@:struct class VkWriteDescriptorSet {
	var type : VkStructureType;
	var next : NextPtr;
	public var dstSet : VkDescriptorSet;
	public var dstBinding : Int;
	public var dstArrayElement : Int;
	public var descriptorCount : Int;
	public var descriptorType : VkDescriptorType;
	public var pImageInfo : ArrayStruct<VkDescriptorImageInfo>;
	public var pBufferInfo : ArrayStruct<VkDescriptorBufferInfo>;
	public var pTexelBufferView : ArrayStruct<VkBufferView>;
	public function new() {
		type = WRITE_DESCRIPTOR_SET;
	}
}

@:struct class VkCopyDescriptorSet {
	var type : VkStructureType;
	var next : NextPtr;
	public var srcSet : VkDescriptorSet;
	public var srcBinding : Int;
	public var srcArrayElement : Int;
	public var dstSet : VkDescriptorSet;
	public var dstBinding : Int;
	public var dstArrayElement : Int;
	public var descriptorCount : Int;
	public function new() {
		type = COPY_DESCRIPTOR_SET;
	}
}

enum VkSamplerCreateFlag {
	SUBSAMPLED_EXT;
	SUBSAMPLED_COARSE_EXT;
}

@:enum abstract VkFilter(Int) {
	var NEAREST = 0;
	var LINEAR = 1;
	var CUBIC_IMG = 1000015000;
}

@:enum abstract VkSamplerMipmapMode(Int) {
	var NEAREST = 0;
	var LINEAR = 1;
}


@:enum abstract VkSamplerAddressMode(Int) {
	var REPEAT = 0;
	var MIRRORED_REPEAT = 1;
	var CLAMP_TO_EDGE = 2;
	var CLAMP_TO_BORDER = 3;
	var MIRROR_CLAMP_TO_EDGE = 4;
}

@:enum abstract VkBorderColor(Int) {
	var FLOAT_TRANSPARENT_BLACK = 0;
	var INT_TRANSPARENT_BLACK = 1;
	var FLOAT_OPAQUE_BLACK = 2;
	var INT_OPAQUE_BLACK = 3;
	var FLOAT_OPAQUE_WHITE = 4;
	var INT_OPAQUE_WHITE = 5;
	var FLOAT_CUSTOM_EXT = 1000287003;
	var INT_CUSTOM_EXT = 1000287004;
}

@:struct class VkSamplerCreateInfo {
	var type : VkStructureType;
	var next : NextPtr;
	public var flags : haxe.EnumFlags<VkSamplerCreateFlag>;
	public var magFilter : VkFilter;
	public var minFilter : VkFilter;
	public var mipmapMode : VkSamplerMipmapMode;
	public var addressModeU : VkSamplerAddressMode;
	public var addressModeV : VkSamplerAddressMode;
	public var addressModeW : VkSamplerAddressMode;
	public var mipLodBias : Single;
	public var anisotropyEnable : VkBool32;
	public var maxAnisotropy : Single;
	public var compareEnable : VkBool32;
	public var compareOp : VkCompareOp;
	public var minLod : Single;
	public var maxLod : Single;
	public var borderColor : VkBorderColor;
	public var unnormalizedCoordinates : VkBool32;
	public function new() {
		type = SAMPLER_CREATE_INFO;
	}
}

@:hlNative("?sdl","vk_")
abstract VkContext(hl.Abstract<"vk_context">) {

	public function getLimits() : VkPhysicalDeviceLimits {
		return null;
	}

	public function getDeviceName() {
		return @:privateAccess String.fromUTF8(get_device_name());
	}

	public function getPdeviceFormatProps( format : VkFormat, props : VkFormatProperties ) {
	}

	function get_device_name() : hl.Bytes {
		return null;
	}

	public function initSwapchain( width : Int, height : Int, outImages : hl.NativeArray<VkImage>, outFormat : hl.Ref<VkFormat> ) : Bool {
		return false;
	}

	public function createCommandPool( inf : VkCommandPoolCreateInfo ) : VkCommandPool {
		return null;
	}

	public function allocateCommandBuffers( inf : VkCommandBufferAllocateInfo, buffers : hl.NativeArray<VkCommandBuffer> ) : Bool {
		return false;
	}

	public function getNextImageIndex( sem : VkSemaphore ) : Int {
		return 0;
	}

	public function createSampler( inf : VkSamplerCreateInfo ) : VkSampler {
		return null;
	}

	public function createSemaphore( inf : VkSemaphoreCreateInfo ) : VkSemaphore {
		return null;
	}

	public function waitForFence( fence : VkFence, timeout : Float ) : Bool {
		return false;
	}

	public function resetFence( fence : VkFence ) {
	}

	public function createFence( inf : VkFenceCreateInfo ) : VkFence {
		return null;
	}

	public function createShaderModule( source : hl.Bytes, len : Int ) : VkShaderModule {
		return null;
	}

	public function createGraphicsPipeline( inf : VkGraphicsPipelineCreateInfo ) : VkGraphicsPipeline {
		return null;
	}

	public function createPipelineLayout( inf : VkPipelineLayoutCreateInfo ) : VkPipelineLayout {
		return null;
	}

	public function createRenderPass( inf : VkRenderPassCreateInfo ) : VkRenderPass {
		return null;
	}

	public function createDescriptorSetLayout( inf : VkDescriptorSetLayoutCreateInfo ) : VkDescriptorSetLayout {
		return null;
	}

	public function createDescriptorPool( inf : VkDescriptorPoolCreateInfo ) : VkDescriptorPool {
		return null;
	}

	public function allocateDescriptorSets( inf : VkDescriptorSetAllocateInfo, sets : hl.NativeArray<VkDescriptorSet> ) : Bool {
		return false;
	}

	public function updateDescriptorSets( writeCount : Int, write : ArrayStruct<VkWriteDescriptorSet>, copyCount : Int, copy : ArrayStruct<VkCopyDescriptorSet> ) {
	}

	public function createFramebuffer( inf : VkFramebufferCreateInfo ) : VkFramebuffer {
		return null;
	}

	public function createImageView( inf : VkImageViewCreateInfo ) : VkImageView {
		return null;
	}

	public function createBuffer( inf : VkBufferCreateInfo ) : VkBuffer {
		return null;
	}

	public function getBufferMemoryRequirements( b : VkBuffer, inf : VkMemoryRequirements ) {
	}

	public function allocateMemory( inf : VkMemoryAllocateInfo ) : VkDeviceMemory {
		return null;
	}

	public function bindBufferMemory( b : VkBuffer, mem : VkDeviceMemory, memOffset : Int ) {
		return false;
	}

	public function createImage( inf : VkImageCreateInfo ) : VkImage {
		return null;
	}

	public function getImageMemoryRequirements( b : VkImage, inf : VkMemoryRequirements ) {
	}

	public function bindImageMemory( b : VkImage, mem : VkDeviceMemory, memOffset : Int ) {
		return false;
	}

	public function findMemoryType( allowed : Int, required : haxe.EnumFlags<VkMemoryPropertyFlag> ) : Int {
		return 0;
	}

	public function mapMemory( mem : VkDeviceMemory, offset : Int, size : Int, flags : Int ) : hl.Bytes {
		return null;
	}

	public function unmapMemory( mem : VkDeviceMemory ) {
	}

	public function queueSubmit( submit : VkSubmitInfo, fence : VkFence ) {
	}

	public function queueWaitIdle() {
	}

	public function present( sem : VkSemaphore, currentImage : Int ) {
	}

	public function destroyImage( img : VkImage ) {
	}

	public function destroyImageView( view : VkImageView ) {
	}

	public function destroyFramebuffer( buf : VkFramebuffer ) {
	}

	public function freeCommandBuffers( pool : VkCommandPool, arr : hl.NativeArray<VkCommandBuffer> ) {
	}

	public function destroyCommandPool( pool : VkCommandPool ) {
	}

	public function destroyBuffer( buf : VkBuffer ) {
	}

	public function destroyFence( fence : VkFence ) {
	}

	public function destroySemaphore( sem : VkSemaphore ) {
	}

	public function freeMemory( mem : VkDeviceMemory ) {
	}

	public function destroyDescriptorPool( pool : VkDescriptorPool ) {
	}

	public function destroySampler( sampler : VkSampler ) {
	}

}

@:hlNative("?sdl","vk_")
abstract VkCommandBuffer(hl.Abstract<"vk_command_buffer">) {

	@:hlNative("?sdl","vk_command_begin")
	public function begin( inf : VkCommandBufferBeginInfo ) {
	}

	@:hlNative("?sdl","vk_command_end")
	public function end() {
	}

	public function clearColorImage( img : VkImage, layout : VkImageLayout, colors : ArrayStruct<VkClearColorValue>, colorCount : Int, range : VkImageSubResourceRange ) {
	}

	public function clearDepthStencilImage( img : VkImage, layout : VkImageLayout, values : ArrayStruct<VkClearDepthStencilValue>, valuesCount : Int, range : VkImageSubResourceRange ) {
	}

	public function clearAttachments( attachCount : Int, attachs : ArrayStruct<VkClearAttachment>, rectCount : Int, rects : ArrayStruct<VkClearRect> ) {
	}

	public function drawIndexed( indexCount : Int, instanceCount : Int, firstIndex : Int, vertexOffset : Int, firstInstance : Int ) {
	}

	public function bindPipeline( bindPoint : VkPipelineBindPoint, pipeline : VkGraphicsPipeline ) {
	}

	public function bindIndexBuffer( buffer : VkBuffer, offset : Int, indexType : Int ) {
	}

	public function bindVertexBuffers( first : Int, count : Int, buffers : ArrayStruct<VkBuffer>, offsets : ArrayStruct<VkDeviceSize> ) {
	}

	public function beginRenderPass( begin : VkRenderPassBeginInfo, contents : VkSubpassContents ) {
	}

	public function endRenderPass() {
	}

	public function pushConstants( layout : VkPipelineLayout, flags : haxe.EnumFlags<VkShaderStageFlag>, offset : Int, size : Int, data : hl.Bytes ) {
	}

	public function copyBufferToImage( buf : VkBuffer, img : VkImage, layout : VkImageLayout, count : Int, regions : ArrayStruct<VkBufferImageCopy> ) {
	}

	public function pipelineBarrier(
		srcMask : haxe.EnumFlags<VkPipelineStageFlag>, dstMask : haxe.EnumFlags<VkPipelineStageFlag>, flags : haxe.EnumFlags<VkDependencyFlag>,
		memCount : Int, memBarriers : ArrayStruct<VkMemoryBarrier>,
		bufferCount : Int, bufBarriers : ArrayStruct<VkBufferMemoryBarrier>,
		imageCount : Int, imgBarriers : ArrayStruct<VkImageMemoryBarrier> ) {
	}

	public function bindDescriptorSets( bind : VkPipelineBindPoint, layout : VkPipelineLayout, first : Int, count : Int, sets : ArrayStruct<VkDescriptorSet>, offsetCount : Int, offsets : hl.Bytes ) {
	}

}

@:hlNative("?sdl","vk_")
class Vulkan {

	public static var ENABLE_VALIDATION = false;

	public static function initContext( surface : VkSurface, queueFamily : hl.Ref<Int> ) : VkContext {
		return null;
	}

	public static function compileShader( source : String, fileName : String, mainFunction : String, kind : ShaderKind ) {
		var outSize = -1;
		var bytes = @:privateAccess compile_shader(source.toUtf8(), fileName.toUtf8(), mainFunction.toUtf8(), kind, outSize);
		if( outSize < 0 ) {
			var error = @:privateAccess String.fromUTF8(bytes);
			var lines = source.split("\n");
			throw error+"\n\nin\n\n"+[for( i => l in lines ) StringTools.rpad((i+1)+":"," ",8)+l].join("\n");
		}
		return @:privateAccess new haxe.io.Bytes(bytes, outSize);
	}

	static function compile_shader( source : hl.Bytes, shaderFile : hl.Bytes, mainFunction : hl.Bytes, kind : ShaderKind, outSize : hl.Ref<Int> ) : hl.Bytes {
		return null;
	}

	public static function makeRef<T>( arr : T ) : ArrayStruct<T> {
		return null;
	}

	public static function makeArray<T>( arr : hl.NativeArray<T> ) : ArrayStruct<T> {
		return null;
	}

}