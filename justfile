# Trigger husk-test smoke/probe workflows via `gh workflow run`.
# Each recipe submits `jobs` separate workflow_dispatch runs — these workflows
# use JIT self-hosted runners that are single-use (one job, then deregister),
# so "N jobs" means N separate dispatched runs, not a matrix.

# GPU passthrough smoke test (husk-libvirt-gpu pool)
gpu-smoke jobs="1":
    for i in $(seq 1 {{jobs}}); do gh workflow run gpu-smoke.yml; done

# CPU OS-OCI recycle probe (husk-os-oci pool)
test jobs="1" sleep_seconds="300":
    for i in $(seq 1 {{jobs}}); do gh workflow run test.yml -f sleep_seconds={{sleep_seconds}}; done

# libvirt CPU smoke test (husk-libvirt-cpu pool)
libvirt-smoke jobs="1" sleep_seconds="300":
    for i in $(seq 1 {{jobs}}); do gh workflow run libvirt-smoke.yml -f sleep_seconds={{sleep_seconds}}; done
