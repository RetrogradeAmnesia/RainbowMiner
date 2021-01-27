typedef unsigned int       uint32_t;
typedef unsigned long long uint64_t;
#define ROTL32(x,n) __funnelshift_l((x), (x), (n))
#define ROTR32(x,n) __funnelshift_r((x), (x), (n))
#define min(a,b) ((a<b) ? a : b)
#define mul_hi(a, b) __umulhi(a, b)
#define clz(a) __clz(a)
#define popcount(a) __popc(a)

#define PROGPOW_LANES			32
#define PROGPOW_REGS			16
#define PROGPOW_CNT_MEM			64
#define PROGPOW_CNT_MATH		8
#define PROGPOW_CACHE_WORDS  4096

__device__ __forceinline__ void progPowLoop(const uint32_t loop,
        uint32_t mix[PROGPOW_REGS],
        const uint64_t *g_dag,
        const uint32_t c_dag[PROGPOW_CACHE_WORDS])
{
uint32_t offset;
uint64_t data64;
uint32_t data32;
const uint32_t lane_id = threadIdx.x & (PROGPOW_LANES-1);
// global load
offset = __shfl_sync(0xFFFFFFFF, mix[0], loop%PROGPOW_LANES, PROGPOW_LANES);
offset %= PROGPOW_DAG_WORDS;
offset = offset * PROGPOW_LANES + lane_id;
data64 = g_dag[offset];
// cache load
offset = mix[4] % PROGPOW_CACHE_WORDS;
data32 = c_dag[offset];
mix[4] = ROTL32(mix[4], 3) ^ data32;
// random math
data32 = ROTR32(mix[13], mix[9]);
mix[15] = ROTR32(mix[15], 31) ^ data32;
// cache load
offset = mix[8] % PROGPOW_CACHE_WORDS;
data32 = c_dag[offset];
mix[13] = ROTR32(mix[13], 21) ^ data32;
// random math
data32 = min(mix[2], mix[12]);
mix[10] = (mix[10] * 33) + data32;
// cache load
offset = mix[7] % PROGPOW_CACHE_WORDS;
data32 = c_dag[offset];
mix[11] = (mix[11] * 33) + data32;
// random math
data32 = mul_hi(mix[1], mix[1]);
mix[3] = ROTL32(mix[3], 28) ^ data32;
// cache load
offset = mix[15] % PROGPOW_CACHE_WORDS;
data32 = c_dag[offset];
mix[7] = ROTR32(mix[7], 12) ^ data32;
// random math
data32 = mix[9] | mix[7];
mix[9] = (mix[9] ^ data32) * 33;
// cache load
offset = mix[10] % PROGPOW_CACHE_WORDS;
data32 = c_dag[offset];
mix[12] = (mix[12] * 33) + data32;
// random math
data32 = mix[6] * mix[14];
mix[2] = ROTL32(mix[2], 3) ^ data32;
// cache load
offset = mix[14] % PROGPOW_CACHE_WORDS;
data32 = c_dag[offset];
mix[1] = (mix[1] * 33) + data32;
// random math
data32 = mul_hi(mix[3], mix[1]);
mix[14] = ROTL32(mix[14], 7) ^ data32;
// cache load
offset = mix[15] % PROGPOW_CACHE_WORDS;
data32 = c_dag[offset];
mix[6] = (mix[6] ^ data32) * 33;
// random math
data32 = clz(mix[0]) + clz(mix[8]);
mix[5] = (mix[5] ^ data32) * 33;
// cache load
offset = mix[15] % PROGPOW_CACHE_WORDS;
data32 = c_dag[offset];
mix[0] = (mix[0] * 33) + data32;
// random math
data32 = mix[10] | mix[1];
mix[8] = ROTL32(mix[8], 28) ^ data32;
// consume global load data
mix[0] = (mix[0] ^ data64) * 33;
mix[4] = (mix[4] * 33) + (data64>>32);
}

#ifndef SEARCH_RESULTS
#define SEARCH_RESULTS 4
#endif

#define FNV_PRIME ((uint32_t)0x1000193)

typedef struct {
    uint32_t count;
    struct {
        // One word for gid and 8 for mix hash
        uint32_t gid;
        uint32_t mix[8];
    } result[SEARCH_RESULTS];
} search_results;

typedef struct
{
    uint32_t uint32s[32 / sizeof(uint32_t)];
} hash32_t;

// Implementation based on:
// https://github.com/mjosaarinen/tiny_sha3/blob/master/sha3.c

__device__ __constant__ const uint32_t keccakf_rndc[24] = {
        0x00000001, 0x00008082, 0x0000808a, 0x80008000, 0x0000808b, 0x80000001,
        0x80008081, 0x00008009, 0x0000008a, 0x00000088, 0x80008009, 0x8000000a,
        0x8000808b, 0x0000008b, 0x00008089, 0x00008003, 0x00008002, 0x00000080,
        0x0000800a, 0x8000000a, 0x80008081, 0x00008080, 0x80000001, 0x80008008
};

// Implementation of the permutation Keccakf with width 800.
__device__ __forceinline__ void keccak_f800_round(uint32_t st[25], const int r)
{

    const uint32_t keccakf_rotc[24] = {
            1,  3,  6,  10, 15, 21, 28, 36, 45, 55, 2,  14,
            27, 41, 56, 8,  25, 43, 62, 18, 39, 61, 20, 44
    };
    const int keccakf_piln[24] = {
            10, 7,  11, 17, 18, 3, 5,  16, 8,  21, 24, 4,
            15, 23, 19, 13, 12, 2, 20, 14, 22, 9,  6,  1
    };

    uint32_t t, bc[5];
    // Theta
    for (int i = 0; i < 5; i++)
        bc[i] = st[i] ^ st[i + 5] ^ st[i + 10] ^ st[i + 15] ^ st[i + 20];

    for (int i = 0; i < 5; i++) {
        t = bc[(i + 4) % 5] ^ ROTL32(bc[(i + 1) % 5], 1u);
        for (int j = 0; j < 25; j += 5)
            st[j + i] ^= t;
    }

    // Rho Pi
    t = st[1];
    for (int i = 0; i < 24; i++) {
        uint32_t j = keccakf_piln[i];
        bc[0] = st[j];
        st[j] = ROTL32(t, keccakf_rotc[i]);
        t = bc[0];
    }

    //  Chi
    for (int j = 0; j < 25; j += 5) {
        for (int i = 0; i < 5; i++)
            bc[i] = st[j + i];
        for (int i = 0; i < 5; i++)
            st[j + i] ^= (~bc[(i + 1) % 5]) & bc[(i + 2) % 5];
    }

    //  Iota
    st[0] ^= keccakf_rndc[r];
}

// Implementation of the Keccak sponge construction (with padding omitted)
// The width is 800, with a bitrate of 576, and a capacity of 224.
__device__ __noinline__ uint64_t keccak_f800(hash32_t header, uint64_t seed, hash32_t result)
{
    uint32_t st[25];

#pragma unroll
    for (int i = 0; i < 25; i++)
        st[i] = 0;

#pragma unroll
    for (int i = 0; i < 8; i++)
        st[i] = header.uint32s[i];

    st[8] = (uint32_t)seed;
    st[9] = (uint32_t)(seed >> 32);
#pragma unroll
    for (int i = 0; i < 8; i++)
        st[10+i] = result.uint32s[i];

    for (int r = 0; r < 21; r++) {
        keccak_f800_round(st, r);
    }
    // last round can be simplified due to partial output
    keccak_f800_round(st, 21);

    return (uint64_t)st[0] << 32 | (uint64_t)st[1];
}

__device__ __forceinline__ uint32_t fnv1a(uint32_t *h, uint32_t d)
{
    *h = (*h ^ d) * FNV_PRIME;
    return *h;
}

typedef struct {
    uint32_t z, w, jsr, jcong;
} kiss99_t;

// KISS99 is simple, fast, and passes the TestU01 suite
// https://en.wikipedia.org/wiki/KISS_(algorithm)
// http://www.cse.yorku.ca/~oz/marsaglia-rng.html
__device__ __forceinline__ uint32_t kiss99(kiss99_t *st)
{
    uint32_t znew = (st->z = 36969 * (st->z & 65535) + (st->z >> 16));
    uint32_t wnew = (st->w = 18000 * (st->w & 65535) + (st->w >> 16));
    uint32_t MWC = ((znew << 16) + wnew);
    uint32_t SHR3 = (st->jsr ^= (st->jsr << 17), st->jsr ^= (st->jsr >> 13), st->jsr ^= (st->jsr << 5));
    uint32_t CONG = (st->jcong = 69069 * st->jcong + 1234567);
    return ((MWC^CONG) + SHR3);
}

__device__ __forceinline__ void fill_mix(uint64_t seed, uint32_t lane_id, uint32_t mix[PROGPOW_REGS])
{
    // Use FNV to expand the per-warp seed to per-lane
    // Use KISS to expand the per-lane seed to fill mix
    uint32_t fnv_hash = 0x811c9dc5;
    kiss99_t st;
    st.z = fnv1a(&fnv_hash, (uint32_t)seed);
    st.w = fnv1a(&fnv_hash, (uint32_t)(seed >> 32));
    st.jsr = fnv1a(&fnv_hash, lane_id);
    st.jcong = fnv1a(&fnv_hash, lane_id);
#pragma unroll
    for (int i = 0; i < PROGPOW_REGS; i++)
        mix[i] = kiss99(&st);
}

__global__ void progpow_search(
        uint64_t start_nonce,
        const hash32_t header,
        const uint64_t target,
        const uint64_t *g_dag,
        volatile search_results* g_output
)
{
    __shared__ uint32_t c_dag[PROGPOW_CACHE_WORDS];
    uint32_t const gid = blockIdx.x * blockDim.x + threadIdx.x;
    uint64_t const nonce = start_nonce + gid;

    const uint32_t lane_id = threadIdx.x & (PROGPOW_LANES - 1);

    // Load random data into the cache
    // TODO: should be a new blob of data, not existing DAG data
    for (uint32_t word = threadIdx.x*2; word < PROGPOW_CACHE_WORDS; word += blockDim.x*2)
    {
        uint64_t data = g_dag[word];
        c_dag[word + 0] = data;
        c_dag[word + 1] = data >> 32;
    }

    hash32_t result;
#pragma unroll
    for (int i = 0; i < 8; i++)
        result.uint32s[i] = 0;
    // keccak(header..nonce)
    uint64_t seed = keccak_f800(header, nonce, result);

    __syncthreads();

#pragma unroll 1
    for (uint32_t h = 0; h < PROGPOW_LANES; h++)
    {
        uint32_t mix[PROGPOW_REGS];

        // share the hash's seed across all lanes
        uint64_t hash_seed = __shfl_sync(0xFFFFFFFF, seed, h, PROGPOW_LANES);
        // initialize mix for all lanes
        fill_mix(hash_seed, lane_id, mix);

#pragma unroll 1
        for (uint32_t l = 0; l < PROGPOW_CNT_MEM; l++)
            progPowLoop(l, mix, g_dag, c_dag);


        // Reduce mix data to a single per-lane result
        uint32_t result_lane = 0x811c9dc5;
#pragma unroll
        for (int i = 0; i < PROGPOW_REGS; i++)
            fnv1a(&result_lane, mix[i]);

        // Reduce all lanes to a single 256-bit result
        hash32_t result_hash;
#pragma unroll
        for (int i = 0; i < 8; i++)
            result_hash.uint32s[i] = 0x811c9dc5;

        for (int i = 0; i < PROGPOW_LANES; i += 8)
#pragma unroll
                for (int j = 0; j < 8; j++)
                    fnv1a(&result_hash.uint32s[j], __shfl_sync(0xFFFFFFFF, result_lane, i + j, PROGPOW_LANES));

        if (h == lane_id)
            result = result_hash;
    }

    // keccak(header .. keccak(header..nonce) .. result);
    if (keccak_f800(header, seed, result) > target)
        return;

    uint32_t index = atomicInc((uint32_t *)&g_output->count, 0xffffffff);
    if (index >= SEARCH_RESULTS)
        return;

    g_output->result[index].gid = gid;
#pragma unroll
    for (int i = 0; i < 8; i++)
        g_output->result[index].mix[i] = result.uint32s[i];
}