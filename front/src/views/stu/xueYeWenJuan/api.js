import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const saveOneByType = (params) => {
    return getRequest('/questionnaire/saveOneByType', params)
}
export const getOneByType = (params) => {
    return getRequest('/questionnaire/getOneByType', params)
}
export const editXueYeZiPing = (params) => {
    return getRequest('/studentEvaluate/editXueYeZiPing', params)
}