import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getStudentEvaluateOne = (params) => {
    return getRequest('/studentEvaluate/getOne', params)
}
export const getStudentEvaluateList = (params) => {
    return getRequest('/teacher/getMyStudentEvaluate', params)
}
export const getStudentEvaluateCount = (params) => {
    return getRequest('/studentEvaluate/count', params)
}
export const addStudentEvaluate = (params) => {
    return postRequest('/studentEvaluate/insert', params)
}
export const editStudentEvaluate = (params) => {
    return postRequest('/studentEvaluate/update', params)
}
export const addOrEditStudentEvaluate = (params) => {
    return postRequest('/studentEvaluate/insertOrUpdate', params)
}
export const deleteStudentEvaluate = (params) => {
    return postRequest('/studentEvaluate/delByIds', params)
}
export const editYuShuWai = (params) => {
    return getRequest('/studentEvaluate/editYuShuWai', params)
}