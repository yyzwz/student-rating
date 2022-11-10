import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getStudentEvaluateOne = (params) => {
    return getRequest('/studentEvaluate/getOne', params)
}
export const getStudentEvaluateList = (params) => {
    return getRequest('/studentEvaluate/getAllOnSports', params)
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
export const saveOneByType = (params) => {
    return getRequest('/questionnaire/saveOneByType', params)
}
export const getOneByType = (params) => {
    return getRequest('/questionnaire/getOneByType', params)
}
export const editShenXinTaPing = (params) => {
    return getRequest('/studentEvaluate/editShenXinTaPing', params)
}
export const editSports = (params) => {
    return getRequest('/studentEvaluate/editSports', params)
}