import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getCompetitionOne = (params) => {
    return getRequest('/competition/getOne', params)
}
export const getCompetitionList = (params) => {
    return getRequest('/competition/getMyPage', params)
}
export const getCompetitionCount = (params) => {
    return getRequest('/competition/count', params)
}
export const addCompetition = (params) => {
    return postRequest('/competition/insert', params)
}
export const editCompetition = (params) => {
    return postRequest('/competition/update', params)
}
export const addOrEditCompetition = (params) => {
    return postRequest('/competition/insertOrUpdate', params)
}
export const deleteCompetition = (params) => {
    return postRequest('/competition/delByIds', params)
}