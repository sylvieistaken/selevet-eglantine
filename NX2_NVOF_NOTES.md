# NVIDIA Optical Flow frame generation (NX2)

A third frame generation backend, alongside Lossless Scaling (LSFG) and FSR 3.
It uses the hardware Optical Flow Accelerator on NVIDIA RTX GPUs through `VK_NV_optical_flow`.
It does not use any DLLs: DLSS Frame Generation (`nvngx_dlssg.dll`) requires motion vectors and depth
from the game engine, which an emulator does not have.

## How to enable it
Configuration > Graphics > Frame Generation Type > "NVIDIA Optical Flow (RTX 20+)".
If the GPU/driver doesn't support it, or if anything fails, the program falls back to FSR 3
and writes this to the log (`Render_Vulkan`).

## How it works
1. The presented frame is copied into one of two images (ping-pong).
2. The accelerator computes the flow between the new and previous frame on a dedicated queue
   (`VK_QUEUE_OPTICAL_FLOW_BIT_NV`), then waits for completion with a fence.
3. The flow (S10.5) is copied into a buffer and converted by `nv_optical_flow_convert.comp`
   into an R16G16_SFLOAT image, in pixels.
4. Generated frames use the same interpolation shader as FSR 3.

## Notes
- Never tested on real hardware: it has only been checked that it compiles and that the shader is valid.
- If generated frames appear to move "backwards", launch with the environment variable
  `EDEN_NVOF_INVERT=1` (this inverts the sign of the flow).
- Every frame calls `scheduler.Finish()` to synchronize the optical flow queue:
  simple and safe, but it costs some CPU/GPU parallelism.
- Log lines to look for: "NVIDIA optical flow frame generation ready", "Optical flow queue family",
  "failed:".
