import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getOneByStudent = (params) => {
    return getRequest('/studentEvaluate/getOneByStudent', params)
}