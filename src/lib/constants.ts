import { vec4, vec3 } from 'gl-matrix';

export const CLEAR_COLOR = [1, 1, 1, 1];
export const FRAME_RATE = 30;

export const CAMERA_UP = vec3.fromValues(0, 1, 0);
export const CAMERA_POSITION = vec3.fromValues(0, 10, 0);
export const CAMERA_LOOK_AT = vec3.fromValues(0, 5, -10);

export const MAX_PLANE_POSITION = 80;
export const DEFAULT_RESOLUTION = 512;

export const SIN_60_DEG = (3 ** .5) / 2;
export const COS_60_DEG = .5;
