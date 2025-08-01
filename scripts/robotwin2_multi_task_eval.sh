#!/bin/bash

# RoboTwin2.0多任务DP3策略评估脚本
# Examples:
# bash scripts/robotwin2_multi_task_eval.sh dp3_multi_task multi_task_robotwin2 9999 0 0


# 默认参数
task_name="multi_task_robotwin2"
EPOCH=100
NUM_EPISODES=20
EVAL_SEED=1
HEAD_CAMERA_TYPE="D435"
MAX_STEPS=1000
TASK_CONFIG="demo_clean"
INSTRUCTION_TYPE="unseen"
TASKS=("open_laptop")

alg_name=${1}
task_name=${2}
addition_info=${3}
training_seed=${4}

gpu_id=${5}
exp_name=${task_name}-${alg_name}-${addition_info}
RUN_DIR="${exp_name}_seed${training_seed}"

export HYDRA_FULL_ERROR=1
export CUDA_VISIBLE_DEVICES=${gpu_id}
export TOKENIZERS_PARALLELISM=false

# 显示配置信息
echo "=================================="
echo "RoboTwin2.0多任务DP3策略评估"
echo "=================================="
echo "任务名称: $task_name"
echo "Checkpoint epoch: $EPOCH"
echo "评估回合数: $NUM_EPISODES"
echo "EVAL_SEED: $EVAL_SEED"
echo "头部相机类型: $HEAD_CAMERA_TYPE"
echo "最大步数: $MAX_STEPS"
echo "任务配置: $TASK_CONFIG"
echo "指令类型: $INSTRUCTION_TYPE"
echo "视频保存路径: videos/${task_name}-epoch_${EPOCH}/"
echo "=================================="

python RoboTwin2.0_3D_policy/test_multi_task.py \
    --task_name "$task_name" \
    --epoch "$EPOCH" \
    --num_episodes "$NUM_EPISODES" \
    --seed "$EVAL_SEED" \
    --head_camera_type "$HEAD_CAMERA_TYPE" \
    --max_steps "$MAX_STEPS" \
    --run_dir "$RUN_DIR" \
    --alg_name "$alg_name" \
    --tasks "${TASKS[@]}" \
    --task_config "$TASK_CONFIG" \
    --instruction_type "$INSTRUCTION_TYPE"
